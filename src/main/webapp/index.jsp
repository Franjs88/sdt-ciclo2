<%
    String estado = (String) request.getAttribute("estado");
    if(estado == null){
    estado = ".";
    }
%>
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
            <div id="botonEncendidoIndex" onclick="cambiaIndex();"></div>
            <%
                if(estado.equals("bloqueado")){
                %>
                <script>
                    document.getElementById("botonEncendidoIndex").style.background="red";
                </script>
                <%
                } else if(estado.equals("abierto")){
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
                    <li id="comolink" onclick="obtenerTaxis();">Ver Taxis |</li>
                    <li><a href="generarSolicitud.jsp">Crear Solicitud</a></li>
                    <li><a href="descargarHistorial.jsp"> | Descargar Historial</a></li>
                </ul>
            </div>
        </div>
    </body>
</html>
