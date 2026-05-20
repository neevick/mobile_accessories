package com.mobileshop.util;

import java.io.*;
import java.net.URISyntaxException;
import java.nio.file.*;
import java.util.Arrays;
import java.util.LinkedHashSet;
import java.util.Locale;
import java.util.Set;

public class ImageUtil {

    private static final String[] ALLOWED_EXTENSIONS = {"jpg", "jpeg", "png", "gif", "webp"};
    private static final String PROJECT_DIR_PROPERTY = "mobile.accessories.project.dir";
    private static final String PROJECT_DIR_ENV = "MOBILE_ACCESSORIES_PROJECT_DIR";
    private static final String PROJECT_FOLDER_NAME = "mobile_accessories";
    private static final Path WEBAPP_IMAGE_DIR = Paths.get("src", "main", "webapp", "resources", "images");
    private static Path cachedProjectDir;

    public static String saveImage(InputStream inputStream, String originalFileName, String contextRealPath) {
        return saveImage(inputStream, originalFileName, contextRealPath, null, null);
    }

    public static String saveImage(InputStream inputStream, String originalFileName, String contextRealPath, String productName, String brand) {
        return saveImage(inputStream, originalFileName, contextRealPath, productName, brand, null);
    }

    private static String saveImage(InputStream inputStream, String originalFileName, String contextRealPath, String productName, String brand, String replaceableFileName) {
        if (inputStream == null || originalFileName == null || originalFileName.isEmpty()) {
            return null;
        }
        String extension = getFileExtension(originalFileName).toLowerCase();
        if (!isValidExtension(extension)) {
            System.err.println("Invalid image extension: " + extension);
            return null;
        }
        try {
            Path runtimeImageDir = getRuntimeImageDirectory(contextRealPath);
            Path sourceImageDir = getSourceImageDirectory(contextRealPath);
            Files.createDirectories(runtimeImageDir);
            if (sourceImageDir != null) {
                Files.createDirectories(sourceImageDir);
            }
            String fileName = buildImageFileName(originalFileName, productName, brand, extension, runtimeImageDir, sourceImageDir, replaceableFileName);
            Path targetPath = runtimeImageDir.resolve(fileName);
            Files.copy(inputStream, targetPath, StandardCopyOption.REPLACE_EXISTING);
            System.out.println("Image saved successfully: " + targetPath);
            if (sourceImageDir != null) {
                copyToSourceImageDirectory(targetPath, fileName, sourceImageDir);
                System.out.println("Image copied to source resources folder: " + sourceImageDir.resolve(fileName));
            } else {
                System.out.println("Source image directory was not found; image saved to runtime folder only.");
            }
            return fileName;
        } catch (IOException e) {
            System.err.println("Error saving image: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    public static String updateImage(InputStream inputStream, String originalFileName, String oldFileName, String contextRealPath) {
        return updateImage(inputStream, originalFileName, oldFileName, contextRealPath, null, null);
    }

    public static String updateImage(InputStream inputStream, String originalFileName, String oldFileName, String contextRealPath, String productName, String brand) {
        String savedFileName = saveImage(inputStream, originalFileName, contextRealPath, productName, brand, oldFileName);
        if (savedFileName != null && oldFileName != null && !oldFileName.isEmpty()) {
            if (!savedFileName.equals(oldFileName)) {
                deleteImage(oldFileName, contextRealPath);
            }
        }
        return savedFileName;
    }

    public static boolean deleteImage(String fileName, String contextRealPath) {
        if (fileName == null || fileName.isEmpty()) {
            return true;
        }
        try {
            boolean deleted = false;
            Path runtimeFilePath = getRuntimeImageDirectory(contextRealPath).resolve(fileName);
            if (Files.deleteIfExists(runtimeFilePath)) {
                deleted = true;
                System.out.println("Runtime image deleted successfully: " + runtimeFilePath);
            }
            Path sourceImageDir = getSourceImageDirectory(contextRealPath);
            if (sourceImageDir != null) {
                Path sourceFilePath = sourceImageDir.resolve(fileName);
                if (!sourceFilePath.normalize().equals(runtimeFilePath.normalize())
                        && Files.deleteIfExists(sourceFilePath)) {
                    deleted = true;
                    System.out.println("Source image deleted successfully: " + sourceFilePath);
                }
            }
            return deleted;
        } catch (IOException e) {
            System.err.println("Error deleting image: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public static String getSubmittedFileName(jakarta.servlet.http.Part part) {
        String header = part.getHeader("content-disposition");
        if (header == null) return null;
        for (String token : header.split(";")) {
            token = token.trim();
            if (token.startsWith("filename")) {
                String filename = token.substring(token.indexOf('=') + 2, token.length() - 1);
                int lastSep = Math.max(filename.lastIndexOf('/'), filename.lastIndexOf('\\'));
                if (lastSep >= 0) filename = filename.substring(lastSep + 1);
                return filename;
            }
        }
        return null;
    }

    private static String getFileExtension(String fileName) {
        int lastDot = fileName.lastIndexOf('.');
        if (lastDot == -1 || lastDot == fileName.length() - 1) return "";
        return fileName.substring(lastDot + 1);
    }

    private static boolean isValidExtension(String extension) {
        for (String allowed : ALLOWED_EXTENSIONS) {
            if (allowed.equals(extension)) return true;
        }
        return false;
    }

    private static String buildImageFileName(String originalFileName, String productName, String brand, String extension, Path runtimeImageDirectory, Path sourceImageDirectory, String replaceableFileName) {
        String baseName = cleanFileName(productName);
        if (baseName.isEmpty()) {
            baseName = cleanFileName(removeFileExtension(originalFileName));
        }
        if (baseName.isEmpty()) {
            baseName = "product-image";
        }

        // Keep the product name readable and avoid overwriting another image.
        String fileName = baseName + "." + extension;
        int counter = 2;
        while (imageExists(runtimeImageDirectory, fileName) || imageExists(sourceImageDirectory, fileName)) {
            if (fileName.equals(replaceableFileName)) {
                return fileName;
            }
            fileName = baseName + "-" + counter + "." + extension;
            counter++;
        }
        return fileName;
    }

    private static boolean imageExists(Path imageDirectory, String fileName) {
        return imageDirectory != null && Files.exists(imageDirectory.resolve(fileName));
    }

    private static String cleanFileName(String value) {
        if (value == null) {
            return "";
        }
        return value.trim().replaceAll("[\\\\/:*?\"<>|]", "").replaceAll("\\s+", " ");
    }

    public static void syncImagesToRuntime(String contextRealPath) {
        try {
            Path sourceImageDir = getSourceImageDirectory(contextRealPath);
            if (sourceImageDir == null) {
                return;
            }
            Path runtimeImageDir = getRuntimeImageDirectory(contextRealPath);
            if (runtimeImageDir.normalize().equals(sourceImageDir.normalize())
                    || !Files.isDirectory(sourceImageDir)) {
                return;
            }

            Files.createDirectories(runtimeImageDir);
            try (DirectoryStream<Path> stream = Files.newDirectoryStream(sourceImageDir)) {
                for (Path sourceImage : stream) {
                    if (Files.isRegularFile(sourceImage)) {
                        Path runtimeImage = runtimeImageDir.resolve(sourceImage.getFileName().toString());
                        Files.copy(sourceImage, runtimeImage, StandardCopyOption.REPLACE_EXISTING);
                    }
                }
            }
        } catch (IOException e) {
            System.err.println("Error syncing images to runtime folder: " + e.getMessage());
        }
    }

    public static String resolveProductImage(String imageFileName, String productName, String brand) {
        return resolveProductImage(imageFileName, productName, brand, null);
    }

    public static String resolveProductImage(String imageFileName, String productName, String brand, String contextRealPath) {
        String currentImage = imageFileName == null ? "" : imageFileName.trim();

        Path runtimeImageDir = getRuntimeImageDirectory(contextRealPath);
        if (!currentImage.isEmpty() && Files.isRegularFile(runtimeImageDir.resolve(currentImage))) {
            return currentImage;
        }

        Path sourceImageDir = getSourceImageDirectory(contextRealPath);
        if (sourceImageDir != null && !currentImage.isEmpty() && Files.isRegularFile(sourceImageDir.resolve(currentImage))) {
            return currentImage;
        }

        String matchedFileName = findMatchingImageFile(runtimeImageDir, productName, brand);
        if (matchedFileName != null) {
            return matchedFileName;
        }

        matchedFileName = sourceImageDir == null ? null : findMatchingImageFile(sourceImageDir, productName, brand);
        if (matchedFileName != null) {
            return matchedFileName;
        }

        return currentImage.isEmpty() ? null : currentImage;
    }

    public static String getExpectedProductImageName(String productName, String brand) {
        return getExpectedProductImageName(productName, brand, null, null);
    }

    private static String getExpectedProductImageName(String productName, String brand, Path firstImageDir, Path secondImageDir) {
        String baseName = cleanFileName(productName);
        if (baseName.isEmpty()) {
            return null;
        }

        String[] extensions = {"jpg", "jpeg", "png", "gif", "webp"};
        for (String extension : extensions) {
            String fileName = baseName + "." + extension;
            if (isExistingImage(firstImageDir, fileName) || isExistingImage(secondImageDir, fileName)) {
                return fileName;
            }
        }
        return null;
    }

    private static boolean isExistingImage(Path imageDir, String fileName) {
        return imageDir != null && Files.isRegularFile(imageDir.resolve(fileName));
    }

    private static String findMatchingImageFile(Path imageDirectory, String productName, String brand) {
        if (!Files.isDirectory(imageDirectory)) {
            return null;
        }

        String productKey = normalizeImageName(productName);

        try (DirectoryStream<Path> stream = Files.newDirectoryStream(imageDirectory)) {
            for (Path imagePath : stream) {
                if (!Files.isRegularFile(imagePath)) {
                    continue;
                }

                String fileName = imagePath.getFileName().toString();
                String extension = getFileExtension(fileName).toLowerCase(Locale.ROOT);
                if (!isValidExtension(extension)) {
                    continue;
                }

                String fileKey = normalizeImageName(removeFileExtension(fileName));
                if (!productKey.isEmpty() && fileKey.contains(productKey)) {
                    return fileName;
                }
            }
        } catch (IOException e) {
            System.err.println("Error finding matching product image: " + e.getMessage());
        }
        return null;
    }

    private static String removeFileExtension(String fileName) {
        int lastDot = fileName.lastIndexOf('.');
        if (lastDot <= 0) {
            return fileName;
        }
        return fileName.substring(0, lastDot);
    }

    private static String normalizeImageName(String value) {
        if (value == null) {
            return "";
        }
        return value.toLowerCase(Locale.ROOT).replaceAll("[^a-z0-9]", "");
    }

    public static Path getSourceImageDirectory(String contextRealPath) {
        if (cachedProjectDir != null && Files.isDirectory(cachedProjectDir.resolve(WEBAPP_IMAGE_DIR))) {
            return cachedProjectDir.resolve(WEBAPP_IMAGE_DIR);
        }

        Path projectDir = findConfiguredProjectDirectory();
        for (Path start : getProjectSearchStarts(contextRealPath)) {
            if (projectDir != null) {
                break;
            }
            projectDir = findProjectDirectory(start);
        }
        if (projectDir == null) {
            projectDir = findProjectDirectoryInCommonCloneLocations();
        }
        if (projectDir != null) {
            cachedProjectDir = projectDir;
            System.out.println("Using source image directory: " + projectDir.resolve(WEBAPP_IMAGE_DIR));
            return projectDir.resolve(WEBAPP_IMAGE_DIR);
        }
        System.err.println("Could not find source src/main/webapp/resources/images folder.");
        return null;
    }

    private static Set<Path> getProjectSearchStarts(String contextRealPath) {
        Set<Path> starts = new LinkedHashSet<>();
        addPath(starts, getClassLocation());
        addPath(starts, Paths.get("").toAbsolutePath());
        addPropertyPath(starts, "user.dir");
        addPropertyPath(starts, "catalina.base");
        addPropertyPath(starts, "catalina.home");
        addPropertyPath(starts, "wtp.deploy");
        if (contextRealPath != null && !contextRealPath.trim().isEmpty()) {
            Path realPath = Paths.get(contextRealPath).toAbsolutePath();
            addPath(starts, realPath);
            Path workspacePath = findEclipseWorkspaceFromDeployedPath(realPath);
            addPath(starts, workspacePath);
        }
        return starts;
    }

    private static Path findProjectDirectory(Path start) {
        Path current = Files.isRegularFile(start) ? start.getParent() : start;
        while (current != null) {
            if (Files.isDirectory(current.resolve(WEBAPP_IMAGE_DIR))) {
                return current;
            }
            current = current.getParent();
        }
        return null;
    }

    private static Path findConfiguredProjectDirectory() {
        String configuredPath = System.getProperty(PROJECT_DIR_PROPERTY);
        if (configuredPath == null || configuredPath.trim().isEmpty()) {
            configuredPath = System.getenv(PROJECT_DIR_ENV);
        }
        if (configuredPath == null || configuredPath.trim().isEmpty()) {
            return null;
        }

        Path projectDir = Paths.get(configuredPath.trim()).toAbsolutePath();
        if (Files.isDirectory(projectDir.resolve(WEBAPP_IMAGE_DIR))) {
            return projectDir;
        }
        return null;
    }

    private static Path findEclipseWorkspaceFromDeployedPath(Path deployedPath) {
        Path current = deployedPath;
        while (current != null) {
            if (".metadata".equalsIgnoreCase(current.getFileName() == null ? "" : current.getFileName().toString())) {
                return current.getParent();
            }
            current = current.getParent();
        }
        return null;
    }

    private static Path findProjectDirectoryInCommonCloneLocations() {
        Set<Path> roots = new LinkedHashSet<>();
        addPropertyPath(roots, "user.home");

        String userHome = System.getProperty("user.home");
        if (userHome != null && !userHome.trim().isEmpty()) {
            Path home = Paths.get(userHome).toAbsolutePath();
            for (Path child : Arrays.asList(
                    Paths.get("Desktop"),
                    Paths.get("Documents"),
                    Paths.get("OneDrive"),
                    Paths.get("OneDrive", "Desktop"),
                    Paths.get("OneDrive", "Documents"),
                    Paths.get("eclipse-workspace"))) {
                addPath(roots, home.resolve(child));
            }
        }

        for (Path root : roots) {
            Path projectDir = findProjectDirectoryUnder(root, 10);
            if (projectDir != null) {
                return projectDir;
            }
        }
        return null;
    }

    private static Path findProjectDirectoryUnder(Path root, int maxDepth) {
        if (root == null || maxDepth < 0 || !Files.isDirectory(root)) {
            return null;
        }

        if (PROJECT_FOLDER_NAME.equalsIgnoreCase(root.getFileName() == null ? "" : root.getFileName().toString())
                && Files.isDirectory(root.resolve(WEBAPP_IMAGE_DIR))) {
            return root.toAbsolutePath();
        }
        if (Files.isDirectory(root.resolve(WEBAPP_IMAGE_DIR))) {
            return root.toAbsolutePath();
        }
        if (maxDepth == 0) {
            return null;
        }

        try (DirectoryStream<Path> stream = Files.newDirectoryStream(root)) {
            for (Path child : stream) {
                if (!Files.isDirectory(child) || isIgnoredSearchDirectory(child)) {
                    continue;
                }
                Path projectDir = findProjectDirectoryUnder(child, maxDepth - 1);
                if (projectDir != null) {
                    return projectDir;
                }
            }
        } catch (IOException | SecurityException e) {
            return null;
        }
        return null;
    }

    private static boolean isIgnoredSearchDirectory(Path path) {
        String name = path.getFileName() == null ? "" : path.getFileName().toString().toLowerCase(Locale.ROOT);
        return name.equals(".git")
                || name.equals("target")
                || name.equals("bin")
                || name.equals("node_modules")
                || name.equals(".metadata")
                || name.equals("appdata");
    }

    private static void addPropertyPath(Set<Path> paths, String propertyName) {
        String value = System.getProperty(propertyName);
        if (value != null && !value.trim().isEmpty()) {
            addPath(paths, Paths.get(value).toAbsolutePath());
        }
    }

    private static void addPath(Set<Path> paths, Path path) {
        if (path != null) {
            paths.add(path.toAbsolutePath().normalize());
        }
    }

    private static Path getClassLocation() {
        try {
            return Paths.get(ImageUtil.class.getProtectionDomain().getCodeSource().getLocation().toURI()).toAbsolutePath();
        } catch (URISyntaxException | NullPointerException | IllegalArgumentException e) {
            return null;
        }
    }

    private static Path getRuntimeImageDirectory(String contextRealPath) {
        if (contextRealPath == null || contextRealPath.isEmpty()) {
            return WEBAPP_IMAGE_DIR.toAbsolutePath();
        }
        return Paths.get(contextRealPath, "resources", "images");
    }

    private static void copyToSourceImageDirectory(Path runtimeImage, String fileName, Path sourceImageDir) throws IOException {
        Path sourceImage = sourceImageDir.resolve(fileName);
        if (sourceImage.normalize().equals(runtimeImage.normalize())) {
            return;
        }
        Files.createDirectories(sourceImageDir);
        Files.copy(runtimeImage, sourceImage, StandardCopyOption.REPLACE_EXISTING);
    }
}
