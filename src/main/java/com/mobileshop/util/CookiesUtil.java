package com.mobileshop.util;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Utility class for common cookie operations.
 */
public class CookiesUtil {

    /**
     * Sets a cookie with the given attributes.
     */
    public static void setCookie(HttpServletResponse response, String name, String value, int maxAgeSeconds, boolean httpOnly, String path) {
        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge(maxAgeSeconds);
        cookie.setHttpOnly(httpOnly);
        cookie.setPath(path);
        response.addCookie(cookie);
    }

    /**
     * Deletes a cookie by name (sets maxAge to 0).
     */
    public static void deleteCookie(HttpServletResponse response, String name, String path) {
        Cookie cookie = new Cookie(name, "");
        cookie.setMaxAge(0);
        cookie.setPath(path);
        response.addCookie(cookie);
    }

    /**
     * Retrieves a cookie value from the request, or null if not present.
     */
    public static String getCookieValue(HttpServletRequest request, String name) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (name.equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }
}
