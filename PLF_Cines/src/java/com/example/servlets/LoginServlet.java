package com.example.servlets;

import com.example.model.DatabaseManager;
import com.example.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/AccederUsuario")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String correo = request.getParameter("mail-2");
        String contrasena = request.getParameter("pswd-2");

        try {
            Usuario usuario = DatabaseManager.getInstance().getUsuarioPorCorreo(correo, contrasena);

            if (usuario != null) {
                HttpSession session = request.getSession();
                session.setAttribute("usuario", usuario);
                // Configura la cookie de sesión manualmente si es necesario
                Cookie cookie = new Cookie("JSESSIONID", session.getId());
                cookie.setHttpOnly(true);
                cookie.setPath("/");
                response.addCookie(cookie);
                
                if (usuario.getCorreo().equals("admin@example.com") && usuario.getContraseña().equals("admin123")) {
                    // Redirige al panel de administración si el usuario es administrador
                    response.sendRedirect("panelAdmin.jsp");
                } else {
                    // Redirige a la página de bienvenida si es un usuario regular
                    response.sendRedirect("index.jsp");
                }
            } else {
                // Usuario no encontrado o credenciales incorrectas
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401 Unauthorized
                response.getWriter().println("Credenciales incorrectas. Por favor, inténtelo de nuevo.");
            }
        } catch (SQLException e) {
            // Manejo específico para errores de SQL
            log("Error de base de datos durante la autenticación: " + e.getMessage(), e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500 Internal Server Error
            response.getWriter().println("Ocurrió un error interno. Por favor, inténtelo más tarde.");
        } catch (Exception e) {
            // Manejo general de excepciones
            log("Error inesperado durante la autenticación: " + e.getMessage(), e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500 Internal Server Error
            response.getWriter().println("Ocurrió un error inesperado. Por favor, inténtelo más tarde.");
        }
    }
}
