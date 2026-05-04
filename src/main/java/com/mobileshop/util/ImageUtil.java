package com.mobileshop.util;

import java.io.*;
import java.nio.file.*;
import java.util.UUID;

public class ImageUtil {

    private static final String IMAGES_DIR = "resources" + File.separator + "images";
    private static final String[] ALLOWED_EXTENSIONS = {"jpg", "jpeg", "png", "gif", "webp"};

    public static String saveImage(InputStream inputStream, String originalFileName, String contextRealPath) {
        if (inputStream == null || originalFileName == null || originalFileName.isEmpty()) {
            return null;
        }
        String extension = getFileExtension(originalFileName).toLowerCase();
        if (!isValidExtension(extension)) {
            System.err.println("Invalid image extension: " + extension);
            return null;
        }
        String fileName = UUID.randomUUID().toString() + "." + extension;
        try {
            Path targetDir = Paths.get(contextRealPath, IMAGES_DIR);
            Files.createDirectories(targetDir);
            Path targetPath = targetDir.resolve(fileName);
            Files.copy(inputStream, targetPath, StandardCopyOption.REPLACE_EXISTING);
            return fileName;
        } catch (IOException e) {
            System.err.println("Error saving image: " + e.getMessage());
            return null;
        }
    }

    public static String updateImage(InputStream inputStream, String originalFileName, String oldFileName, String contextRealPath) {
        if (oldFileName != null && !oldFileName.isEmpty()) {
            deleteImage(oldFileName, contextRealPath);
        }
        return saveImage(inputStream, originalFileName, contextRealPath);
    }

    public static boolean deleteImage(String fileName, String contextRealPath) {
        if (fileName == null || fileName.isEmpty()) {
            return true;
        }
        try {
            Path filePath = Paths.get(contextRealPath, IMAGES_DIR, fileName);
            return Files.deleteIfExists(filePath);
        } catch (IOException e) {
            System.err.println("Error deleting image: " + e.getMessage());
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
}
