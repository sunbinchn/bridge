package com.bridge.filter;

import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class LoginFilter extends OncePerRequestFilter {
    private static final String NOT_FILTER_URI = "/bridge/login";
    private static final String NOT_FILTER_STATIC = "/bridge/static";

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        if (request.getRequestURI().startsWith(NOT_FILTER_STATIC) || request.getRequestURI().startsWith(NOT_FILTER_URI) || request.getSession().getAttribute("userName") != null) {
            filterChain.doFilter(request, response);
        } else {
            response.sendRedirect("/bridge/login/index.html");
        }
    }
}
