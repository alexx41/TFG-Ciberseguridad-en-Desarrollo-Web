
package com.example.servlets;

import com.example.model.Comentario;
import com.example.model.DatabaseManager;
import com.example.model.Fecha;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;


@WebServlet("/GestionComentarios")
public class GestionComentario extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("escribirComentario".equals(accion)) {
            guardarComentario(request, response);
        } else {
            response.getWriter().println("Acción no reconocida");
        }
    }

    private void guardarComentario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtén los parámetros del formulario de comentarios
        String texto = request.getParameter("textoComentario");
        System.out.println(texto);
        int valoracion = Integer.parseInt(request.getParameter("valoracionComentario"));
        System.out.println(valoracion);
        String fechaNacimiento = request.getParameter("fecha");
        Fecha fecha = new Fecha(fechaNacimiento);
        System.out.println(fecha);
        String emailUsuario = request.getParameter("emailDelUsuario");
        System.out.println(emailUsuario);
        String nombrePelicula = request.getParameter("nombrePelicula");
        System.out.println(nombrePelicula);

        try {
            Comentario comentario = new Comentario(texto, valoracion, fecha, emailUsuario, nombrePelicula);
            DatabaseManager.getInstance().guardarComentario(comentario);
            response.sendRedirect("indexDetallado.jsp?id=" + nombrePelicula);
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error al guardar el comentario en el servlet.");
        }
    }

}
