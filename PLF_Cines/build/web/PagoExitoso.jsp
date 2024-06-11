<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Pago Exitoso</title>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js" integrity="sha512-GsLlZN/3F2ErC5ifS5QtgpiJtWd43JWSuIgh7mbzZ8zBps+dvLusV+eNQATqgA/HdeKFVgA5v3S/cIrLF7QnIg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js" crossorigin="anonymous" referrerpolicy="no-referrer"></script>        
        <link rel="stylesheet" href="estilos/pagoexitoso.css">
    </head>
    <body>

        <h2>Pago Exitoso</h2>
        <p>Su número de Referencia es: <%= session.getAttribute("numRef") %></p>

        <h3>Entradas Reservadas:</h3>
        <%-- Mostrar información de cada entrada --%>
        <% String butacasJSON = (String) session.getAttribute("butacasSeleccionadas");

           // Eliminar corchetes y comillas para obtener pares clave-valor separados por comas
           String cleanString = butacasJSON.replaceAll("[\\[\\]\\{\\}\" ]", "");

           // Dividir la cadena en pares clave-valor
           String[] keyValuePairs = cleanString.split(",");

           // Crear una lista de mapas para almacenar las butacas seleccionadas
           List<Map<String, Integer>> butacasList = new ArrayList<>();

           // Iterar sobre los pares clave-valor y agregar a la lista de mapas
           for (int i = 0; i < keyValuePairs.length; i += 2) {
               String[] filaKC = keyValuePairs[i].split(":");
               String[] columnaKC = keyValuePairs[i + 1].split(":");
               Map<String, Integer> butaca = Map.of("fila", Integer.parseInt(filaKC[1]), "columna", Integer.parseInt(columnaKC[1]));
               butacasList.add(butaca);
           }
        %>
        <ul>
            <% for (Map<String, Integer> butaca : butacasList) { %>
            <li>Fila: <%= butaca.get("fila") %>, Columna: <%= butaca.get("columna") %></li>
                <% } %>
        </ul>

        <p>Día: <%= session.getAttribute("fecha") %></p>
        <p>Hora: <%= session.getAttribute("hora") %></p>
        <div class="section">
            <%-- Mostrar el código QR generado en el JavaScript --%>

            <h3>Código QR:</h3>
            <%
                String datosReserva = "Numero de Referencia: " + session.getAttribute("numRef") +
                                      "Dia: " + session.getAttribute("fecha") +
                                      "Hora: " + session.getAttribute("hora") +
                                      "Butacas Reservadas: " + butacasJSON;
            %>

            <div id="codigoQR"></div>        
        </div>
        <button onclick="imprimirPDF()">Imprimir PDF</button>

        <a href="index.jsp"><button type="button">Seguir Comprando</button></a>

        <script>

            var qrcode = new QRCode("codigoQR", {
                text: '<%= datosReserva %>',
                width: 200,
                height: 200,

                correctLevel: QRCode.CorrectLevel.H
            });
            function imprimirPDF() {
                const options = {
                    margin: 1,
                    filename: 'pago_exitoso.pdf',
                    image: {type: 'jpeg', quality: 0.98},
                    html2canvas: {
                        scale: 2,
                        letterRendering: true,
                    },
                    jsPDF: {unit: 'in', format: 'a4', orientation: 'portrait'},
                };

                const content = document.body;
                html2pdf().from(content).set(options).save();
            }
        </script>

    </body>
</html>
