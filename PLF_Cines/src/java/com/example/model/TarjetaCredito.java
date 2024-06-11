
package com.example.model;


public class TarjetaCredito {
    
    private String numeroTarjeta;
    private String nombreTitular;

    private String fecha;
    private String codigoSeguridad;
    private String email_user;

    public TarjetaCredito(String numeroTarjeta, String nombreTitular, String fecha, String codigoSeguridad, String email_user) {
        this.numeroTarjeta = numeroTarjeta;
        this.nombreTitular = nombreTitular;
        this.fecha = fecha;
        this.codigoSeguridad = codigoSeguridad;
        this.email_user = email_user;
    }

    public String getNumeroTarjeta() {
        return numeroTarjeta;
    }

    public void setNumeroTarjeta(String numeroTarjeta) {
        this.numeroTarjeta = numeroTarjeta;
    }

    public String getNombreTitular() {
        return nombreTitular;
    }

    public void setNombreTitular(String nombreTitular) {
        this.nombreTitular = nombreTitular;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getCodigoSeguridad() {
        return codigoSeguridad;
    }

    public void setCodigoSeguridad(String codigoSeguridad) {
        this.codigoSeguridad = codigoSeguridad;
    }

    public String getEmail_user() {
        return email_user;
    }

    public void setEmail_user(String email_user) {
        this.email_user = email_user;
    }

   
    
    
    
}
