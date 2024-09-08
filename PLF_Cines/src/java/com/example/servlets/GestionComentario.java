package com.example.servlets;

import com.example.model.Comentario;
import com.example.model.DatabaseManager;
import com.example.model.Fecha;
import org.apache.commons.text.StringEscapeUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.regex.Pattern;

@WebServlet("/GestionComentarios")
public class GestionComentario extends HttpServlet {

    private static final Pattern SCRIPT_PATTERN = Pattern.compile("<\\s*script[\\s\\S]*?>[\\s\\S]*?<\\s*/\\s*script\\s*>", Pattern.CASE_INSENSITIVE);
    private static final Pattern DANGEROUS_PATTERNS[] = {
        Pattern.compile("<\\s*iframe\\b[^>]*>[\\s\\S]*?<\\s*/\\s*iframe\\s*>", Pattern.CASE_INSENSITIVE),
        Pattern.compile("<\\s*object\\b[^>]*>[\\s\\S]*?<\\s*/\\s*object\\s*>", Pattern.CASE_INSENSITIVE),
        Pattern.compile("<\\s*embed\\b[^>]*>[\\s\\S]*?<\\s*/\\s*embed\\s*>", Pattern.CASE_INSENSITIVE)
    };

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("escribirComentario".equals(accion)) {

            guardarComentario(request, response);
        } else {
            response.getWriter().println("Acción no reconocida");
        }
    }

    private boolean isValidComentario(String comentario) {
        System.out.println(comentario);
        if (SCRIPT_PATTERN.matcher(comentario).find()) {
            return false;
        }
        for (Pattern pattern : DANGEROUS_PATTERNS) {
            if (pattern.matcher(comentario).find()) {
                return false;
            }
        }
        return true;
    }

    private void guardarComentario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtén los parámetros del formulario de comentarios
        String texto = request.getParameter("textoComentario");
        System.out.println("Comentario recibido: " + texto);

        // Validar el comentario para evitar inyecciones de código
        if (isValidComentario(texto)) {
            try {

                // Sanitizar datos de entrada
                String comentarioSanitizado = StringEscapeUtils.escapeHtml4(texto);
                
                
                int valoracion = Integer.parseInt(request.getParameter("valoracionComentario"));
                System.out.println("Valoración recibida: " + valoracion);
                String fechaNacimiento = request.getParameter("fecha");
                Fecha fecha = new Fecha(fechaNacimiento);
                System.out.println("Fecha recibida: " + fecha);
                String emailUsuario = request.getParameter("emailDelUsuario");
                System.out.println("Email del usuario: " + emailUsuario);
                String nombrePelicula = request.getParameter("nombrePelicula");
                System.out.println("Nombre de la película: " + nombrePelicula);

                Comentario comentario = new Comentario(texto, valoracion, fecha, emailUsuario, nombrePelicula);
                DatabaseManager.getInstance().guardarComentario(comentario);
                response.sendRedirect("indexDetallado.jsp?id=" + nombrePelicula);
            } catch (SQLException e) {
                e.printStackTrace();
                response.getWriter().println("Error al guardar el comentario en el servlet.");
            }
        } else {
            response.getWriter().println("El comentario contiene código no permitido.");
        }
    }

}
