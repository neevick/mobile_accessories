package com.mobileshop.filter;

import com.mobileshop.model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * Authentication filter for role-based access control.
 * Protects /admin/* and /user/* URLs.
 * Redirects unauthorized users to login page.
 */
@WebFilter(urlPatterns = "/*")
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization if needed
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        String uri = request.getRequestURI();
        String contextPath = request.getContextPath();

        // Get session without creating a new one
        HttpSession session = request.getSession(false);

        // Allow public access to auth pages and static resources
        if (uri.startsWith(contextPath + "/auth") || 
            uri.startsWith(contextPath + "/css") || 
            uri.startsWith(contextPath + "/js") || 
            uri.startsWith(contextPath + "/resources")) {
            filterChain.doFilter(servletRequest, servletResponse);
            return;
        }

        // Check if user is logged in
        if (session == null || session.getAttribute("user") == null) {
            // Allow access to public pages for non-logged-in users
            if (uri.equals(contextPath + "/") || 
                uri.equals(contextPath + "/index.jsp") ||
                uri.equals(contextPath + "/products") ||
                uri.equals(contextPath + "/about.jsp") ||
                uri.equals(contextPath + "/contact")) {
                filterChain.doFilter(servletRequest, servletResponse);
                return;
            }
            response.sendRedirect(contextPath + "/auth?action=login");
            return;
        }

        User user = (User) session.getAttribute("user");

        // Allow access to profile for all logged-in users
        if (uri.equals(contextPath + "/profile")) {
            filterChain.doFilter(servletRequest, servletResponse);
            return;
        }

        // Admin users should only access admin pages
        if (user.isAdmin()) {
            // If admin tries to access non-admin pages, redirect to dashboard
            if (!uri.startsWith(contextPath + "/admin/") && !uri.equals(contextPath + "/admin")) {
                response.sendRedirect(contextPath + "/admin/dashboard");
                return;
            }
        }

        // Admin area protection - only admin role can access
        if (uri.startsWith(contextPath + "/admin/")) {
            if (!user.isAdmin()) {
                response.sendRedirect(contextPath + "/products");
                return;
            }
        }

        filterChain.doFilter(servletRequest, servletResponse);
    }

    @Override
    public void destroy() {
        // Cleanup if needed
    }
}
