package com.mobileshop.util;

import java.io.*;
import java.net.URISyntaxException;
import java.nio.file.*;
import java.util.Locale;

public class ImageUtil {

    private static final String[] ALLOWED_EXTENSIONS = {"jpg", "jpeg", "png", "gif", "webp"};
    private static final String PROJECT_DIR_PROPERTY = "mobile.accessories.project.dir";
    private static final Path WEBAPP_IMAGE_DIR = Paths.get("src", "main", "webapp", "resources", "images");
    private static Path cachedProjectDir;

    public static String saveImage(InputStream inputStream, String originalFileName, String contextRealPath) {
        return saveImage(inputStream, originalFileName, contextRealPath, null, null);
    }

    public static String saveImage(InputStream inputStream, String originalFileName, String contextRealPath, String productName, String brand) {
        if (inputStream == null || originalFileName == null || originalFileName.isEmpty()) {
            return null;
        }
        String extension = getFileExtension(originalFileName).toLowerCase();
        if (!isValidExtension(extension)) {
            System.err.println("Invalid image extension: " + extension);
            return null;
        }
        try {
            Path sourceImageDir = getSourceImageDirectory(contextRealPath);
            Files.createDirectories(sourceImageDir);
            String fileName = buildImageFileName(originalFileName, productName, brand, extension, sourceImageDir);
            Path targetPath = sourceImageDir.resolve(fileName);
            Files.copy(inputStream, targetPath, StandardCopyOption.REPLACE_EXISTING);
            copyToRuntimeImageDirectory(targetPath, fileName, contextRealPath);
            System.out.println("Image saved successfully: " + targetPath);
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
        String savedFileName = saveImage(inputStream, originalFileName, contextRealPath, productName, brand);
        if (savedFileName != null && oldFileName != null && !oldFileName.isEmpty()) {
            deleteImage(oldFileName, contextRealPath);
        }
        return savedFileName;
    }

    public static boolean deleteImage(String fileName, String contextRealPath) {
        if (fileName == null || fileName.isEmpty()) {
            return true;
        }
        try {
            boolean deleted = false;
            Path sourceFilePath = getSourceImageDirectory(contextRealPath).resolve(fileName);
            if (Files.deleteIfExists(sourceFilePath)) {
                deleted = true;
                System.out.println("Image deleted successfully: " + sourceFilePath);
            }
            Path runtimeFilePath = getRuntimeImageDirectory(contextRealPath).resolve(fileName);
            if (!runtimeFilePath.normalize().equals(sourceFilePath.normalize())
                    && Files.deleteIfExists(runtimeFilePath)) {
                deleted = true;
                System.out.println("Runtime image deleted successfully: " + runtimeFilePath);
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

    private static String buildImageFileName(String originalFileName, String productName, String brand, String extension, Path imageDirectory) {
        String baseName = cleanFileName(productName);
        String brandName = cleanFileName(brand);
        if (!baseName.isEmpty() && !brandName.isEmpty()) {
            baseName = baseName + " " + brandName;
        }
        if (baseName.isEmpty()) {
            baseName = cleanFileName(removeFileExtension(originalFileName));
        }
        if (baseName.isEmpty()) {
            baseName = "product-image";
        }

        // Keep the product name readable and avoid overwriting another image.
        String fileName = baseName + "." + extension;
        int counter = 2;
        while (Files.exists(imageDirectory.resolve(fileName))) {
            fileName = baseName + "-" + counter + "." + extension;
            counter++;
        }
        return fileName;
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
        if (imageFileName == null || imageFileName.trim().isEmpty()) {
            return null;
        }

        Path runtimeImageDir = getRuntimeImageDirectory(contextRealPath);
        if (Files.isRegularFile(runtimeImageDir.resolve(imageFileName))) {
            return imageFileName;
        }

        Path sourceImageDir = getSourceImageDirectory(null);
        if (Files.isRegularFile(sourceImageDir.resolve(imageFileName))) {
            return imageFileName;
        }

        String matchedFileName = findMatchingImageFile(runtimeImageDir, productName, brand);
        if (matchedFileName != null) {
            return matchedFileName;
        }

        matchedFileName = findMatchingImageFile(sourceImageDir, productName, brand);
        if (matchedFileName != null) {
            return matchedFileName;
        }

        return null;
    }

    private static String findMatchingImageFile(Path imageDirectory, String productName, String brand) {
        if (!Files.isDirectory(imageDirectory)) {
            return null;
        }

        String productKey = normalizeImageName(productName);
        String productBrandKey = normalizeImageName(productName + " " + brand);

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
                if (!productBrandKey.isEmpty() && fileKey.contains(productBrandKey)) {
                    return fileName;
                }
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

        Path projectDir = findProjectDirectory(getClassLocation());
        if (projectDir == null) {
            projectDir = findProjectDirectory(Paths.get("").toAbsolutePath());
        }
        if (projectDir == null && contextRealPath != null) {
            projectDir = findProjectDirectory(Paths.get(contextRealPath).toAbsolutePath());
        }
        if (projectDir == null) {
            projectDir = findConfiguredProjectDirectory();
        }
        if (projectDir == null) {
            projectDir = findProjectDirectoryInCommonLocations();
        }
        if (projectDir != null) {
            cachedProjectDir = projectDir;
            return projectDir.resolve(WEBAPP_IMAGE_DIR);
        }
        return getRuntimeImageDirectory(contextRealPath);
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
            configuredPath = System.getenv("MOBILE_ACCESSORIES_PROJECT_DIR");
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

    private static Path findProjectDirectoryInCommonLocations() {
        String userHome = System.getProperty("user.home");
        if (userHome == null || userHome.trim().isEmpty()) {
            return null;
        }

        Path home = Paths.get(userHome);
        Path[] candidates = {
                home.resolve(Paths.get("OneDrive", "Documents", "Desktop", "Real APT Coursework", "mobile_accessories")),
                home.resolve(Paths.get("Documents", "Desktop", "Real APT Coursework", "mobile_accessories")),
                home.resolve(Paths.get("Desktop", "Real APT Coursework", "mobile_accessories")),
                home.resolve(Paths.get("OneDrive", "Desktop", "Real APT Coursework", "mobile_accessories")),
                home.resolve("mobile_accessories")
        };

        for (Path candidate : candidates) {
            if (Files.isDirectory(candidate.resolve(WEBAPP_IMAGE_DIR))) {
                return candidate.toAbsolutePath();
            }
        }

        Path[] searchRoots = {
                home.resolve("Desktop"),
                home.resolve("Documents"),
                home.resolve("OneDrive"),
                home.resolve("eclipse-workspace")
        };

        for (Path searchRoot : searchRoots) {
            Path projectDir = findProjectDirectoryUnder(searchRoot, 8);
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
        if (Files.isDirectory(root.resolve(WEBAPP_IMAGE_DIR))) {
            return root.toAbsolutePath();
        }
        if (maxDepth == 0) {
            return null;
        }

        try (DirectoryStream<Path> stream = Files.newDirectoryStream(root)) {
            for (Path child : stream) {
                if (Files.isDirectory(child)) {
                    Path projectDir = findProjectDirectoryUnder(child, maxDepth - 1);
                    if (projectDir != null) {
                        return projectDir;
                    }
                }
            }
        } catch (IOException | SecurityException e) {
            return null;
        }
        return null;
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

    private static void copyToRuntimeImageDirectory(Path sourceImage, String fileName, String contextRealPath) throws IOException {
        Path runtimeImageDir = getRuntimeImageDirectory(contextRealPath);
        Path runtimeImage = runtimeImageDir.resolve(fileName);
        if (runtimeImage.normalize().equals(sourceImage.normalize())) {
            return;
        }
        Files.createDirectories(runtimeImageDir);
        Files.copy(sourceImage, runtimeImage, StandardCopyOption.REPLACE_EXISTING);
    }
}
