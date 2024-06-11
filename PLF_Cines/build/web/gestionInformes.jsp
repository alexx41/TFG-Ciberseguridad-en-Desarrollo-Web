<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.model.Sala" %>
<%@ page import="com.example.model.Pelicula" %>
<%@ page import="com.example.model.Entrada" %>
<%@ page import="com.example.model.DatabaseManager" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestion de Informes</title>
        <link rel="stylesheet" type="text/css" href="estilos/panelAdmin.css">
    </head>
    <body>
        <% if (session.getAttribute("usuario") != null) { %>
        <header>
            <div class="navbar">
            <a href="gestionPeliculas.jsp">Gestión de Películas</a>
            <a href="gestionSalas.jsp">Gestión de Salas</a>
            <a href="gestionEntradas.jsp">Gestión de Entradas</a>
            <a href="gestionReservas.jsp">Gestión de Reservas</a>
            <a href="gestionInformes.jsp">Gestión de Informes</a>
            <a href="login.jsp">Volver</a>
        </div>
        </header>
        <form action="GestionInforme" method="post">
            <h2>Informe por Géneros</h2>
            <label>Selecciona un género:</label>
            <select name="generoElegido">
                <% List<String> listaGeneros = new ArrayList<>();
                    List<Pelicula> listaPeliculas = new ArrayList<>();
                    try {
                        //Tenemos la lista con todas las peliculas
                        listaPeliculas = DatabaseManager.getInstance().getAllPeliculas();

                        //Una vez que tengamos la lista, podemos recorrer los generos que hay en cada pelicula y añadirlo a la lista
                        for (Pelicula pelicula : listaPeliculas) {
                            if (!listaGeneros.contains(pelicula.getGenero())) {
                                listaGeneros.add(pelicula.getGenero());
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    for (String genero : listaGeneros) { %>
                <option value="<%= genero %>"><%= genero %></option>
                <% } %>
            </select><br>
            <!-- Campos que esta ocultos para saber que accion esta realizando el servlet y no crear un servlet exclusivo para cada accion de 
            boorar de insertar, modificar o mostrar contenido-->

            <label>Resultados</label>
            <input type="text" id="resultadoFiltroGenero" name="resultadoFiltroGenero" value="${resultadoFiltroGenero}"><br>
            
            <input type="hidden" name="filtro" value="genero">
            <button type="submit">Filtrar por género</button><br>

        </form>
        <form action="GestionInforme" method="post">
            <h2>Informe por salas</h2>
            <label>Selecciona una sala</label>
            <select name="salaElegida">
                <% List<Sala> listaSalas = new ArrayList<>();
                    List<String> nombreSalas = new ArrayList<>();
                    try {
                        
                        listaSalas = DatabaseManager.getInstance().getAllSalas();

                        //Una vez que tengamos la lista, podemos recorrer los generos que hay en cada pelicula y añadirlo a la lista
                        for (Sala sala : listaSalas) {
                            nombreSalas.add(sala.getNombreSala());
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    for (String nombre : nombreSalas) { %>
                <option value="<%= nombre %>"><%= nombre %></option>
                <% } %>
            </select><br>
            <label>Resultados</label>
            <input type="text" id="resultadoFiltroSala" name="resultadoFiltroSala" value="${resultadoFiltroSala}"><br>

            <input type="hidden" name="filtro" value="sala">
            <button type="submit">Filtrar por sala</button><br>
        </form>

          <% } else { %>
                     <p>Acesso restringido.</p>
                    <% } %>
                    
    </body>
</html>
