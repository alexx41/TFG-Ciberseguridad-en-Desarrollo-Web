<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.model.Sala" %>
<%@ page import="com.example.model.Entrada" %>
<%@ page import="com.example.model.Pelicula" %>
<%@ page import="com.example.model.Usuario" %>

<%@ page import="com.example.model.DatabaseManager" %>
<%@ page import="com.example.model.Fecha" %>

<%@ page import="java.time.LocalTime" %>


<%@ page import="java.util.ArrayList" %>

<%
    List<Entrada> entradas = new ArrayList<>();
try {
    Sala salaSelec = (Sala) session.getAttribute("sala");
    String fechaStr = (String) session.getAttribute("fecha");
    Fecha fecha = new Fecha(fechaStr);
    System.out.println(fecha);
    entradas = DatabaseManager.getAllEntradas(); 
    
    String horaStr = (String) session.getAttribute("hora");
    LocalTime hora = LocalTime.parse(horaStr);
    
    Pelicula peliculaSeleccionada = (Pelicula) session.getAttribute("pelicula");


%>
<!DOCTYPE html>
<html>
    <head>

        <meta charset="UTF-8">
        <title>Selección de Butacas</title>
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

        <script async src="https://www.googletagmanager.com/gtag/js?id=UA-155274620-1"></script>

        <link href="estilos/bootstrap.css" rel="stylesheet">
        <link href="estilos/style.css" rel="stylesheet">
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
            <div align="center" style="padding-top: 30px" class="formreservas">
                <div class="row clearfix">
                    <h1 class="text-center title-1"><%= peliculaSeleccionada.getNombre() %></h1>
                    <hr class="mx-auto small text-hr" style="margin-bottom: 30px !important">

                    <div style="clear:both">
                        <hr>
                    </div>
                </div>
                <h3 class="titulo-cine">SELECCION BUTACAS: <%= salaSelec.getNombreSala() %></h3>
                <div class = "tablabutaca">
                <form action="GestionButacas" method="post">
                    <table style='border-collapse: collapse;'>
                        <%
                        for (int i = 0; i < salaSelec.getFilas(); i++) {
                        %>
                        <tr>
                            <%
                            for (int j = 0; j < salaSelec.getColumnas(); j++) {
                                int fila = i + 1;
                                int columna = j + 1;
                                boolean ocupadaPorOtroCliente = false;

                                // Verificar si la butaca está ocupada por otras entradas
                                for (Entrada entrada : entradas) {
                                        System.out.println(entrada.getFecha().equals(fecha));
                                    if (entrada.getNombreSala().equals(salaSelec.getNombreSala()) &&
                                        entrada.getFila() == fila &&
                                        entrada.getColumna() == columna &&
                                        entrada.getFecha().toLocalDate().equals(fecha.toLocalDate()) &&
                                        entrada.getHora().equals(hora))
                                         {
                                        ocupadaPorOtroCliente = true;


                                        break;
                                    }
                                }
                            %>
                            <td>
                                <%
                                    if (!ocupadaPorOtroCliente) {
                                        // Verificar si la butaca está libre u ocupada
                                        boolean ocupada = false;  

                                        if (ocupada) {
                                        //Si esta ocupada , establecer imagen butaca_seleccionada
                                %>
                                <img class='butaca ocupada'
                                     src='butacas/butaca_seleccionada.png'
                                     alt='Butaca <%= fila %>-<%= columna %>'
                                     data-fila='<%= fila %>' data-columna='<%= columna %>'>
                                <%
                                } else {
                               //Si esta libre , establecer imagen butaca_libre

                                %>
                                <img class='butaca'
                                     src='butacas/butaca_libre.png'
                                     alt='Butaca <%= fila %>-<%= columna %>'
                                     data-fila='<%= fila %>' data-columna='<%= columna %>'>
                                <%
                                }
                            } else {
                            //Si esta ocupada previamente, establecer imagen butaca_ocupada
                                %>
                                <img class='butaca ocupadaPorClientes'
                                     src='butacas/butaca_ocupada.png'
                                     alt='Butaca <%= fila %>-<%= columna %>'
                                     data-fila='<%= fila %>' data-columna='<%= columna %>'>
                                <%
                                }
                                %>

                            </td>
                            <%
                            }
                                }
                            %>
                        </tr>

                    </table>

                    <!-- Campo oculto para almacenar butacas seleccionadas -->
                    <input type="hidden" name="butacasSeleccionadas" id="butacasSeleccionadas">

                    <button type="submit" name="comprarButacas">Comprar</button>
                </form>
                </div>
            </div>
        </div>
        <script>
            $(document).ready(function () {
                var butacasSeleccionadas = [];

                // Manejar el clic en una butaca
                $('.butaca').click(function () {
                    var fila = $(this).data('fila');
                    var columna = $(this).data('columna');

                    // Verificar si la butaca está ocupada por otros clientes
                    var ocupadaPorClientes = $(this).hasClass('ocupadaPorClientes');

                    if (!ocupadaPorClientes) {
                        // Verificar si la butaca está libre u ocupada
                        var ocupada = $(this).hasClass('ocupada');

                        if (!ocupada) {
                            // Si la butaca está libre, cambiar a ocupada
                            $(this).attr('src', 'butacas/butaca_seleccionada.png');
                            $(this).addClass('ocupada');
                            // Agregar la butaca a la lista de seleccionadas
                            butacasSeleccionadas.push({fila: fila, columna: columna});
                        } else {
                            // Si la butaca está ocupada, cambiar a libre
                            $(this).attr('src', 'butacas/butaca_libre.png');
                            $(this).removeClass('ocupada');
                            // Eliminar la butaca de la lista de seleccionadas
                            butacasSeleccionadas = butacasSeleccionadas.filter(function (butaca) {
                                return butaca.fila !== fila || butaca.columna !== columna;
                            });
                        }
                    }

                    // Actualizar el campo oculto con las butacas seleccionadas
                    $('#butacasSeleccionadas').val(JSON.stringify(butacasSeleccionadas));
                });
            });
        </script>
    </body>

</html>
<%
} catch (Exception e) {
    e.printStackTrace();
}
%>