<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.model.Pelicula" %>
<%@ page import="com.example.model.Sala" %>
<%@ page import="com.example.model.DatabaseManager" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.example.model.Usuario" %>

<!DOCTYPE html>
<html>
    <head>


        <title>Reserva</title>

        <meta charset="utf-8">

        <link href="estilos/bootstrap.css" rel="stylesheet">
        <link href="estilos/style.css" rel="stylesheet">
        <link href="estilos/owl.carousel.css" rel="stylesheet">

        <link href="estilos/fontawesome.min.css" rel="stylesheet"/>

        <link href="estilos/multicines.css" rel="stylesheet" />

    </head>
    <body>
        <div id="wrapper" class="d-flex flex-column">
            <div class="header">
                <nav class="navbar fixed-top navbar-site navbar-light bg-light navbar-expand-lg" role="navigation" >
                    <div class="container">
                        <div class="navbar-identity">

                            <button data-target=".navbar-collapse" data-toggle="collapse" class="navbar-toggler pull-right" type="button">
                                <svg xmlns="https://www.w3.org/2000/svg" viewbox="0 0 30 30" width="30" height="30" focusable="false"><title>Menu</title><path stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-miterlimit="10" d="M4 7h22M4 15h22M4 23h22"/></svg>
                            </button>
                        </div>
                        <div class="navbar-collapse collapse" style="height: auto;">
                            <ul class="nav navbar-nav ml-auto navbar-right">
                                <li class="nav-item"><a href="index.jsp" class="nav-link">VOLVER AL MENU DE PELICULAS</a></li>
                                <li class="nav-item"><a href="login.jsp" class="nav-link">REGISTRARSE</a></li>
                                <% if (session.getAttribute("usuario") != null) { %>
                                    <%
                                        // Obtener el usuario de la sesión
                                        System.out.println("EN EL INDEX USUARIO");
                                        Usuario usuario = (Usuario) session.getAttribute("usuario");
                                        String correoUsuario = (usuario != null) ? usuario.getCorreo() : "";
                                    %>
                                    <li class="nav-item">
                                        <form id="logout-form" action="Logout" method="post" style="display: inline;">
                                            <button type="submit" class="nav-link">CERRAR SESIÓN</button>
                                        </form>
                                    </li> 
                                    <% }%>
                            </ul>
                        </div>
                    </div>
                </nav>
            </div>
            <!-- /.header -->
            <% 
            Pelicula peliculaSeleccionada = (Pelicula) session.getAttribute("pelicula");
            %>
            <div class="main-container inner-page flex-fill " style="padding-top: 30px !important;">
                <div  style="padding-top: 30px" class="container">
                    <div  align="center" class="row clearfix">
                        <h1 class="text-center title-1"><%= peliculaSeleccionada.getNombre() %></h1>
                        <hr class="mx-auto small text-hr" style="margin-bottom: 30px !important">

                        <div style="clear:both">
                            <hr>
                        </div>
                    </div>
                    <h3 class="titulo-cine">RESERVA</h3>

                    <div class="col-3 d-none d-md-block">

                        <a href="<%= peliculaSeleccionada.getUrl_image() %>" data-toggle="lightbox"><img class="img-responsive" style="width: 262px;" src="<%= peliculaSeleccionada.getUrl_image() %>" /></a>


                    </div>
                    <div class ="formreservas">
                    <form action="Reservas" method="post" onsubmit="return validarFormulario()" >

                        <label for="fecha">Fecha:</label>
                        <input type ="date" name="fecha" id="fecha" required>
                        <br>

                        <label for="hora">Hora:</label>
                        <select name="hora" id="hora" required></select>
                        <br>

                        <br>
                        <label for="sala">Sala:</label>
                        <select name="salaSeleccionada" id="salaSeleccionada">
                            <% List<Sala> salas = new ArrayList<>();
                                try {
                                    salas = DatabaseManager.getAllSalas(); // Obtener todas las salas

                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            %>
                            <option value="" disabled selected>Selecciona una sala</option>
                            <% 
                                for (Sala sala : salas) { 
                                    if (sala.getNombre_pelicula().equals(peliculaSeleccionada.getNombre())) {
                            %>
                            <option value="<%= sala.getNombreSala() %>"><%= sala.getNombreSala()%></option>
                            <% 
                                    }
                                } 
                            %>
                        </select>
                        <br>
                        <br>

                        <button type="submit">Seleccionar Butacas</button>
                    </form>
                    </div>
                </div>
            </div>
        </div>
        <script>
            // Obtener la duración de la película y el tiempo entre pases desde el servidor
            var duracionPelicula = <%= peliculaSeleccionada.getDuracion() %>;
            var tiempoEntrePases = 15; // minutos

            // Establecer la hora de inicio y fin del cine
            var horaInicioCine = new Date();
            horaInicioCine.setHours(14, 0, 0, 0);

            var horaFinCine = new Date();
            horaFinCine.setHours(23, 59, 0, 0);

            // Calcular los horarios de los pases redondeando a las horas enteras
            var horarios = [];
            var sdf = new Intl.DateTimeFormat('en-US', {hour: 'numeric', minute: 'numeric', hour12: false});

            // Calcular el número de pases en el día
            var numPases = Math.floor((9 * 60 / duracionPelicula));
            for (var i = 0; i < numPases; i++) {
                // Formatear la hora
                var horaRedondeada = new Date(horaInicioCine);
                horaRedondeada.setMinutes(Math.round(horaRedondeada.getMinutes() / 15) * 15);

                // Verificar si la hora está dentro del horario del cine
                if (horaRedondeada >= horaInicioCine && horaRedondeada <= horaFinCine) {
                    horarios.push(sdf.format(horaRedondeada));
                }

                // Calcular el siguiente pase
                horaInicioCine.setMinutes(horaInicioCine.getMinutes() + duracionPelicula + tiempoEntrePases);
            }

            // Limpiar la lista de horarios
            var selectHora = document.getElementById("hora");
            selectHora.innerHTML = "";

            // Añadir opciones a la lista de horarios
            for (var i = 0; i < horarios.length; i++) {
                var option = document.createElement("option");
                option.value = horarios[i];
                option.textContent = horarios[i];

                // Agregar la opción a la lista de horarios
                selectHora.appendChild(option);
            }
            function validarFormulario() {
                // Validar la fecha
                var fechaInput = document.getElementById("fecha").value;
                var fechaSeleccionada = new Date(fechaInput);
                var fechaActual = new Date();

                if (fechaSeleccionada < fechaActual) {
                    alert("La fecha no puede ser menor que el día actual");
                    return false;
                }
                // El formulario es válido
                return true;
            }
        </script>
    </body>
</html>
