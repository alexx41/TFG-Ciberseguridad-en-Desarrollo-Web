package com.example.servlets;

import com.example.model.DatabaseManager;
import com.example.model.Entrada;
import com.example.model.Fecha;
import com.example.model.Reserva;
import com.example.model.Sala;
import com.example.model.Usuario;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.time.LocalTime;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/GestionButacas")
public class GestionButacas extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        System.out.println(session.getId());

        Usuario usuarioActual = (Usuario) session.getAttribute("usuario");
        String emailUsuario = usuarioActual.getCorreo();
        Sala sala = (Sala) session.getAttribute("sala");
        // Obtener la cadena JSON de la solicitud
        String numRef = "";
        int numeroAleatorioRef = new Random().nextInt(90000000) + 100000000;
        numRef = "R" + Integer.toString(numeroAleatorioRef);// Crear una nueva entrada

        session.setAttribute("numRef", numRef);

        //CREACION DE RESERVA
        // Obtener la cadena JSON de la solicitud
        String butacasSeleccionadasJSON = request.getParameter("butacasSeleccionadas");
        session.setAttribute("butacasSeleccionadas", butacasSeleccionadasJSON);
        // Eliminar corchetes y comillas para obtener pares clave-valor separados por comas
        String cleanString = butacasSeleccionadasJSON.replaceAll("[\\[\\]\\{\\}\" ]", "");

        System.out.println(cleanString);

        // Dividir la cadena en pares clave-valor
        String[] keyValuePairs = cleanString.split(",");

        //IdEntrada para la entradas seleccionadas por el mismo usuario.
        String idEntrada = "";
        int numeroAleatorio = new Random().nextInt(90000000) + 100000000;
        idEntrada = "E" + Integer.toString(numeroAleatorio);// Crear una nueva entrada

        // Obtener información adicional de la sesión
        String fechaStr = (String) session.getAttribute("fecha");
        Fecha fecha = new Fecha(fechaStr);

        String horaStr = (String) session.getAttribute("hora");
        LocalTime hora = LocalTime.parse(horaStr);

        int fila = 0;
        int columna = 0;

        String nombreSala = sala.getNombreSala();

        for (int i = 0; i < keyValuePairs.length; i += 2) {
            // Obtener la fila y columna
            //Extraemos la fila
            String[] filaKC = keyValuePairs[i].split(":");
            fila = Integer.parseInt(filaKC[1]);
            //Extraemos la columna
            String[] columnaKC = keyValuePairs[i + 1].split(":");
            columna = Integer.parseInt(columnaKC[1]);

            Entrada entrada = new Entrada(idEntrada, fecha, hora, fila, columna, nombreSala);
            Reserva reserva = new Reserva(numRef, emailUsuario, idEntrada, fila, columna);

            try {
                // Guardar la entrada en la base de datos
                DatabaseManager.getInstance().guardarEntrada(entrada);
                DatabaseManager.getInstance().guardarReserva(reserva);

            } catch (SQLException ex) {
                Logger.getLogger(GestionButacas.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        response.sendRedirect(request.getContextPath() + "/PagoExitoso.jsp");

    }
}
