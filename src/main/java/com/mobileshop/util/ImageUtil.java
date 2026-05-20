package com.mobileshop.util;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.nio.file.Paths;
import java.sql.*;

/**
 * ProductImageUtil
 * ------------------------------------------------------------------
 * Utility class responsible for reading and streaming product images.
 *
 * Usage in your servlet:
 *   ProductImageUtil.streamImage(productId, getServletContext(), response);
 * ------------------------------------------------------------------
 */
public class ImageUtil {

    /**
     * Fetches the image filename from DB, then streams the image file
     * to the HTTP response.
     *
     * @param productId      the product whose image should be served
     * @param servletContext used to resolve the file path on disk
     * @param response       the HttpServletResponse to write the image into
     */
    public static void streamImage(int productId,
                                   ServletContext servletContext,
                                   HttpServletResponse response) throws IOException {

        // 1. Get image filename from database
        String imageName = getImageFilename(productId);

        if (imageName == null || imageName.isEmpty()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "No image found for product ID: " + productId);
            return;
        }

        // 2. Sanitise – prevent path traversal attacks
        imageName = Paths.get(imageName).getFileName().toString();

        // 3. Resolve absolute path on disk
        //    Files must be stored at: <webapp-root>/resources/images/<filename>
        String absolutePath = servletContext.getRealPath("/resources/images/" + imageName);
        File imageFile = new File(absolutePath);

        if (!imageFile.exists() || !imageFile.isFile()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND,
                    "Image file not found on disk: " + imageName);
            return;
        }

        // 4. Detect MIME type (image/jpeg, image/png, image/webp …)
        String mimeType = servletContext.getMimeType(imageName);
        if (mimeType == null) {
            mimeType = "image/jpeg"; // safe fallback
        }

        // 5. Set response headers
        response.setContentType(mimeType);
        response.setContentLengthLong(imageFile.length());
        response.setHeader("Cache-Control", "public, max-age=3600"); // cache 1 hour

        // 6. Stream bytes to client
        streamBytes(imageFile, response.getOutputStream());
    }

    /**
     * Overload: stream a raw byte array (e.g. if you store images as BLOBs in DB).
     *
     * @param imageBytes the raw image bytes fetched from DB
     * @param mimeType   e.g. "image/jpeg"
     * @param response   the HttpServletResponse to write the image into
     */
    public static void streamImageBytes(byte[] imageBytes,
                                        String mimeType,
                                        HttpServletResponse response) throws IOException {

        if (imageBytes == null || imageBytes.length == 0) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image data is empty.");
            return;
        }

        if (mimeType == null || mimeType.isEmpty()) {
            mimeType = "image/jpeg";
        }

        response.setContentType(mimeType);
        response.setContentLength(imageBytes.length);
        response.setHeader("Cache-Control", "public, max-age=3600");

        try (OutputStream out = new BufferedOutputStream(response.getOutputStream())) {
            out.write(imageBytes);
        }
    }

    // ── Private Helpers ───────────────────────────────────────────────────────

    /**
     * Queries the database for the image filename of a given product.
     *
     * @param productId the product ID
     * @return the image filename (e.g. "microfiber.jpg"), or null if not found
     */
    private static String getImageFilename(int productId) {
        // Replace with your actual DB connection utility class
        String sql = "SELECT image FROM products WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();               // ← your DB util
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("image");   // column name in your products table
                }
            }
        } catch (SQLException e) {
            System.err.println("[ProductImageUtil] DB error fetching image: " + e.getMessage());
        }
        return null;
    }

    /**
     * Streams a File's bytes into the given OutputStream efficiently.
     */
    private static void streamBytes(File file, OutputStream out) throws IOException {
        try (InputStream in  = new BufferedInputStream(new FileInputStream(file));
             OutputStream bOut = new BufferedOutputStream(out)) {

            byte[] buffer = new byte[8192];
            int bytesRead;
            while ((bytesRead = in.read(buffer)) != -1) {
                bOut.write(buffer, 0, bytesRead);
            }
        }
    }
}
