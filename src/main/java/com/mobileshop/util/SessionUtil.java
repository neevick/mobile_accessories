package com.mobileshop.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

/**
 * Utility class to simplify session attribute handling and flash messages.
 */
public class SessionUtil {

    /**
     * Retrieves the HttpSession, optionally creating a new one.
     */
    public static HttpSession getSession(HttpServletRequest request, boolean create) {
        return request.getSession(create);
    }

    /**
     * Sets a session attribute.
     */
    public static void setAttribute(HttpServletRequest request, String name, Object value) {
        HttpSession session = getSession(request, true);
        session.setAttribute(name, value);
    }

    /**
     * Retrieves a session attribute.
     */
    @SuppressWarnings("unchecked")
    public static <T> T getAttribute(HttpServletRequest request, String name) {
        HttpSession session = getSession(request, false);
        if (session == null) {
            return null;
        }
        return (T) session.getAttribute(name);
    }

    /**
     * Convenience method to set a flash success message.
     */
    public static void setSuccess(HttpServletRequest request, String message) {
        setAttribute(request, "success", message);
    }

    /**
     * Convenience method to set a flash error message.
     */
    public static void setError(HttpServletRequest request, String message) {
        setAttribute(request, "error", message);
    }

    /**
     * Clears flash messages from the session.
     */
    public static void clearMessages(HttpServletRequest request) {
        HttpSession session = getSession(request, false);
        if (session != null) {
            session.removeAttribute("success");
            session.removeAttribute("error");
        }
    }
}
