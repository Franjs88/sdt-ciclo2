<%-- 
    Document   : index
    Created on : May 5, 2013, 7:58:10 PM
    Author     : andres
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SDT</title>
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="funciones.js"></script>
        <link rel="stylesheet" type="text/css" href="estilo.css"/>
    </head>
    <body>
        <div id="encabezado">
            <h1>Despacho de Taxis</h1>
            <div id="enlaces">
                <ul>
                    <li id="comolink" onclick="obtenerTaxis();">Ver Taxis |</li>
                    <li><a href="generarSolicitud.jsp">Crear Solicitud</a></li>
                    <li><a href="descargarHistorial.jsp"> | Descargar Historial</a></li>
                </ul>
            </div>
        </div>
    </body>
</html>
