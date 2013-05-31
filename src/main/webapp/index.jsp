<%@page import="controlador.ControladorServlet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SDT</title>
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="funciones.js"></script>
        <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet">    
        <link rel="stylesheet" type="text/css" href="estilo.css"/>
    </head>
    <body>
        <div id="encabezado">
            <div id="botonEncendidoIndex" onclick="cambiaIndex();"></div>
            <%
                if (!ControladorServlet.isConectado()) {
            %>
            <script>
                document.getElementById("botonEncendidoIndex").style.background = "red";
            </script>
            <%                } else if (ControladorServlet.isConectado()) {
            %>
            <script>
                document.getElementById("botonEncendidoIndex").style.background = "green";
            </script>
            <%                    }
            %>
            <h1>Despacho de Taxis</h1>
            <div id="enlaces">
                <ul>
                    <li id="comolink" onclick="obtenerTaxis();">Ver Taxis |</li>
                    <li><a href="generarSolicitud.jsp">Crear Solicitud</a></li>
                    <li><a href="testDescarga.jsp"> | Descargar Historial</a></li>
                </ul>
            </div>
        </div>
        <div style="text-align: center; position: absolute; top: 200px; left:38%;">
            <img src="http://static6.depositphotos.com/1070259/561/v/950/depositphotos_5613932-Button-taxi.jpg" height="300px" width="300px"/>
        </div>
    </body>
</html>
