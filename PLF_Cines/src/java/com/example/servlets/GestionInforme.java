
package com.example.servlets;

import com.example.model.DatabaseManager;
import com.example.model.Pelicula;
import com.example.model.Sala;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;

@WebServlet("/GestionInforme")
public class GestionInforme extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String filtro = request.getParameter("filtro");

        switch(filtro){
            case "genero":
                //Comprobamos que se quiere filtrar por genero

                //Comprobamos el genero que se ha elegido en el formulario
                String genero = request.getParameter("generoElegido");
                List<Pelicula> peliculas = new ArrayList<>();
                String resultado = "";

                //Una vez que tenemos el genero elegido, vamos a ver las peliculas que tienen el genero que buscamos
                try{
                    peliculas = DatabaseManager.getInstance().getAllPeliculas();
                }catch(Exception e){}
                //Las peliculas que tengan el genero que buscamos, las añadiremos a la lista resultado
                for(Pelicula pelicula : peliculas){
                    if(pelicula.getGenero().equals(genero)){
                        if(resultado.equals(""))
                            resultado = resultado + pelicula.getNombre();
                        else
                            resultado = resultado + ", " + pelicula.getNombre();
                    }
                }
                //Una vez que tengamos
                request.setAttribute("resultadoFiltroGenero", resultado);
                request.getRequestDispatcher("gestionInformes.jsp").forward(request, response);
                
                break; 

            case "sala":
                String nombreSala = request.getParameter("salaElegida");
                List<Sala> salas = new ArrayList<>();
                String resultadoSalas = "";

                //Una vez que tenemos el genero elegido, vamos a ver las peliculas que tienen el genero que buscamos
                try{
                    salas = DatabaseManager.getAllSalas();
                }catch(Exception ignored){}
                //Las peliculas que tengan el genero que buscamos, las añadiremos a la lista resultado
                for(Sala sala : salas){
                    if(sala.getNombreSala().equals(nombreSala)){
                        resultadoSalas = resultadoSalas + sala.getNombre_pelicula() + "\n";
                    }
                }
                //Una vez que tengamos el resultado, lo enviamos de vuelta
                request.setAttribute("resultadoFiltroSala", resultadoSalas);
                request.getRequestDispatcher("gestionInformes.jsp").forward(request, response);    

                break;
                
                
        }
    }
    
    

}
