<%-- 
    Document   : fallo
    Created on : May 27, 2013, 11:18:57 AM
    Author     : andres
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Fallo en comunicaci&oacute;n</title>
        <link rel="stylesheet" type="text/css" href="estilo.css"/>
        <script type="text/javascript"
                src="http://maps.googleapis.com/maps/api/js?v=3.exp&key=AIzaSyDhFJI3JhFGCKkzw_96TcyyUXqMvkfDDmA&sensor=false">
        </script>
        <script src="funciones.js"></script>
    </head>
    <body>
        <div id="encabezado">
            <h1>Despacho de Taxis</h1>
            <div id="enlaces">
                <ul>
                    <li><a href="index.jsp">Inicio</a></li>
                    <li> | </li>
                    <li><a href="generarSolicitud.jsp">Crear Solicitud</a></li>
                </ul>
            </div>
        </div>
        <div id="divFallo">
            <h1>Ha habido un fallo en la comunicaci&oacute;n con el Taxi</h1>
            <form action="ControladorServlet">
                <input onclick="alert('Vuelvo a intentar');" type="submit" value="VolveraIntentar" name="solicitud"/>
            </form>
        </div>
    </body>
</html>
