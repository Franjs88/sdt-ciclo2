<%@page import="controlador.ControladorServlet"%>
<%@page import="modelo.accesodatos.Taxi"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    
    Taxi taxi = (Taxi) request.getAttribute("taxi");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet">    
        <title>Informaci&oacute;n Taxi</title>
        <link rel="stylesheet" type="text/css" href="estilo.css"/>
        <script type="text/javascript"
                src="http://maps.googleapis.com/maps/api/js?v=3.exp&key=AIzaSyDhFJI3JhFGCKkzw_96TcyyUXqMvkfDDmA&sensor=false">
        </script>
        <script src="funciones.js"></script>
    </head>
    <body onload="generarMapa('<%= taxi.getUbicacion()%>');">
        <div id="encabezado">
            <div id="botonEncendidoIndex"></div>
            <%
                if(!ControladorServlet.isConectado()){
                %>
                <script>
                    document.getElementById("botonEncendidoIndex").style.background="red";
                </script>
                <%
                } else if(ControladorServlet.isConectado()){
                %>
                <script>
                    document.getElementById("botonEncendidoIndex").style.background="green";
                </script>
                <%
                }
            %>
            <h1>Despacho de Taxis</h1>
            <div id="enlaces">
                <ul>
                    <li><a href="index.jsp">Inicio</a></li>
                    <li id="comolink" onclick="obtenerTaxis();">| Ver Taxis</li>
                    <li><a href="generarSolicitud.jsp">| Crear Solicitud</a></li>
                </ul> 
            </div>
        </div>
        <div id="infotaxi">
            <h1>Taxi: <%=taxi.getNumBastidor()%></h1>
            <h1>Estado: <%= taxi.getEstado()%></h1>
            <h1>Ubicación Actual: <%= taxi.getUbicacion()%></h1>
            <%
                if (taxi.getEstado().equals("ocupado")) {
            %>
            <h1>Destino: <%= taxi.getDestino()%></h1>
            <%}%>
        </div>
        <div id="map_canvas">
        </div>
    </body>
</html>
