<%@page import="controlador.ControladorServlet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet">
        <title>Solicitud</title>
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="funciones.js"></script>
        <link rel="stylesheet" type="text/css" href="estilo.css"/>
    </head>
    <body>
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
                    <li><a href="testDescarga.jsp"> | Descargar Historial</a></li>
                </ul>
            </div>
        </div>
        <div id="forma">
            <form action="ControladorServlet">
                Nombre: <input type="text" name="Nombre" value="" /><br />
                Ubicaci&oacute;n: <input type="text" name="Direccion" value="" /><br />
                Telefono: <input type="text" name="Telefono" value="" /><br />
                <input type="submit" value="Crear Solicitud" name="solicitud"/>
            </form>
        </div>
    </body>
</html>
