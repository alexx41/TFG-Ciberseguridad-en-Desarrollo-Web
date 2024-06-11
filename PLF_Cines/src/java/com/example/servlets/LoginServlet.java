package com.example.servlets;

import com.example.model.DatabaseManager;
import com.example.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
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
        
            if (usuario.getCorreo().equals("admin@example.com") && usuario.getContraseña().equals("admin123")) {
                HttpSession session = request.getSession();
                session.setAttribute("usuario", usuario);
                response.sendRedirect("panelAdmin.jsp");
            } else {
                if (usuario != null) {
                    System.out.println("Usuario de base de datos: " + usuario.getCorreo() + ", " + usuario.getContraseña());
                    System.out.println("Contrasena leida: "+contrasena);
                    HttpSession session = request.getSession();
                    session.setAttribute("usuario", usuario);
                    response.sendRedirect("welcome.html");
                } else {
                    response.getWriter().println("Usuario y/o contraseña incorrectos.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Ocurrió un error durante la autenticación.");
        }

    }
}
