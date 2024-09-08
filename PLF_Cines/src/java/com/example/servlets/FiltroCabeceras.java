package com.example.servlets;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
public class FiltroCabeceras implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpServletRequest httpRequest = (HttpServletRequest) request;

        // Configuración CSP
        httpResponse.setHeader("Content-Security-Policy",
                "default-src 'self';"
                + "script-src 'self' https://apis.google.com https://www.youtube.com https://cdnjs.cloudflare.com; "
                + "style-src 'self' https://fonts.googleapis.com https://cdnjs.cloudflare.com; "
                + "frame-src 'self' https://www.youtube.com; "
                + "object-src 'none'; "
                + "font-src 'self' https://fonts.gstatic.com;");

        // Protección contra Clickjacking con X-Frame-Options
        httpResponse.setHeader("X-Frame-Options", "DENY");

        // Protección contra MIME-sniffing con X-Content-Type-Options
        httpResponse.setHeader("X-Content-Type-Options", "nosniff");

        // Configuración de SameSite y HttpOnly para cookies de sesión
        Cookie[] cookies = httpRequest.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("JSESSIONID".equals(cookie.getName())) {
                    cookie.setHttpOnly(true);
                    cookie.setPath("/");
                    cookie.setMaxAge(-1); // Mantener la cookie durante la sesión
                    httpResponse.addHeader("Set-Cookie", cookie.getName() + "=" + cookie.getValue()
                            + "; Path=/"
                            + "; HttpOnly"
                            + "; SameSite=Strict");
                    
                }
            }
        }

        // Pasar la solicitud al siguiente filtro
        chain.doFilter(request, response);
    }
}

