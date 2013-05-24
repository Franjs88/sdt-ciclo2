<%-- 
    Document   : descargarHistorial
    Created on : May 24, 2013, 2:54:47 PM
    Author     : andres
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Historial</title>
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="funciones.js"></script>
        <link rel="stylesheet" type="text/css" href="estilo.css"/>

    </head>
    <body>
        <div id="encabezado">
            <h1>Despacho de Taxis</h1>
            <div id="enlaces">
                <ul>
                    <li><a href="index.jsp">Inicio</a></li>
                    <li><a href="generarSolicitud.jsp"> | Crear Solicitud</a></li>
                </ul>
            </div>
        </div>
        <div id="forma">
            <form action="ControladorServlet">
                <input type="submit" value="Descargar Historial" name="solicitud"/>
            </form>
        </div>
    </body>
</html>
