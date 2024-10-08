
package com.example.model;

public class Pelicula {

    private String nombre;
    private String sinopsis;
    private String paginaOficial;
    private String tituloOriginal;

    private String genero;
    private String nacionalidad;
    private int duracion;
    private int año;
    private String distribuidora;
    private String director;
    private int clasificacionEdad;
    private String otrosDatos;
    private String actores;
    private String url_image;
    private String url_video;

    public Pelicula(String nombre, String sinopsis, String paginaOficial, String tituloOriginal, String genero, String nacionalidad, int duracion, int año, String distribuidora, String director, int clasificacionEdad, String otrosDatos, String actores, String url_image, String url_video) {
        this.nombre = nombre;
        this.sinopsis = sinopsis;
        this.paginaOficial = paginaOficial;
        this.tituloOriginal = tituloOriginal;
        this.genero = genero;
        this.nacionalidad = nacionalidad;
        this.duracion = duracion;
        this.año = año;
        this.distribuidora = distribuidora;
        this.director = director;
        this.clasificacionEdad = clasificacionEdad;
        this.otrosDatos = otrosDatos;
        this.actores = actores;
        this.url_image = url_image;
        this.url_video = url_video;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getSinopsis() {
        return sinopsis;
    }

    public void setSinopsis(String sinopsis) {
        this.sinopsis = sinopsis;
    }

    public String getPaginaOficial() {
        return paginaOficial;
    }

    public void setPaginaOficial(String paginaOficial) {
        this.paginaOficial = paginaOficial;
    }

    public String getTituloOriginal() {
        return tituloOriginal;
    }

    public void setTituloOriginal(String tituloOriginal) {
        this.tituloOriginal = tituloOriginal;
    }

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public String getNacionalidad() {
        return nacionalidad;
    }

    public void setNacionalidad(String nacionalidad) {
        this.nacionalidad = nacionalidad;
    }

    public int getDuracion() {
        return duracion;
    }

    public void setDuracion(int duracion) {
        this.duracion = duracion;
    }

    public int getAño() {
        return año;
    }

    public void setAño(int año) {
        this.año = año;
    }

    public String getDistribuidora() {
        return distribuidora;
    }

    public void setDistribuidora(String distribuidora) {
        this.distribuidora = distribuidora;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public int getClasificacionEdad() {
        return clasificacionEdad;
    }

    public void setClasificacionEdad(int clasificacionEdad) {
        this.clasificacionEdad = clasificacionEdad;
    }

    public String getOtrosDatos() {
        return otrosDatos;
    }

    public void setOtrosDatos(String otrosDatos) {
        this.otrosDatos = otrosDatos;
    }

    public String getActores() {
        return actores;
    }

    public void setActores(String actores) {
        this.actores = actores;
    }

    public String getUrl_image() {
        return url_image;
    }

    public void setUrl_image(String url_image) {
        this.url_image = url_image;
    }

    public String getUrl_video() {
        return url_video;
    }

    public void setUrl_video(String url_video) {
        this.url_video = url_video;
    }

    @Override
    public String toString() {
        return "Pelicula{" + "nombre=" + nombre + ", sinopsis=" + sinopsis + ", paginaOficial=" + paginaOficial + ", tituloOriginal=" + tituloOriginal + ", genero=" + genero + ", nacionalidad=" + nacionalidad + ", duracion=" + duracion + ", a\u00f1o=" + año + ", distribuidora=" + distribuidora + ", director=" + director + ", clasificacionEdad=" + clasificacionEdad + ", otrosDatos=" + otrosDatos + ", actores=" + actores + ", url_image=" + url_image + ", url_video=" + url_video + '}';
    }
}