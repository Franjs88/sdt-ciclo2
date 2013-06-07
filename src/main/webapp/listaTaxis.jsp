<%@page import="controlador.ControladorServlet"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.accesodatos.Taxi"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String estado = (String) request.getAttribute("estado");
    if (estado == null) {
        estado = ".";
    }
    List<Integer> taxis = (List<Integer>) request.getAttribute("taxis");
    ArrayList<Taxi> listaInfoTaxis = (ArrayList<Taxi>) request.getAttribute("infoTaxis");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet">    
        <title>Taxis</title>
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
                    <li><a href="generarSolicitud.jsp">| Crear Solicitud</a></li>
                    <li><a href="testDescarga.jsp"> | Descargar Historial</a></li>
                </ul>
            </div>
        </div>
        <div id="listataxis" >
            <table style="border: 1px solid black;">
                <tr>
                    <th>Imagen</th>
                    <th>N&uacute;mero de Bastidor</th>
                </tr>
                <%
                    for (int i = 0; i < taxis.size(); i++) {
                        if (ControladorServlet.isConectado()) {
                %>
                <tr id="<%=taxis.get(i)%>" title="<%=listaInfoTaxis.get(i).getEstado()%>" onclick="mostrarInformacion(this.id, '<%=listaInfoTaxis.get(i).getUbicacion()%>');">
                    <td><img src="http://static6.depositphotos.com/1070259/561/v/950/depositphotos_5613932-Button-taxi.jpg" height="150px" width="150px"/></td>
                    <td style="text-align:center;font-size:larger;"><%=taxis.get(i)%></td>
                </tr>
                <%
                } else {
                %>
                <tr id="<%=taxis.get(i)%>" onclick="mostrarInformacion(this.id, '<%=listaInfoTaxis.get(i).getUbicacion()%>');">
                    <td><img src="http://static6.depositphotos.com/1070259/561/v/950/depositphotos_5613932-Button-taxi.jpg" height="150px" width="150px"/></td>
                    <td style="text-align:center;font-size:larger;"><%=taxis.get(i)%></td>
                </tr>
                <%
                        }
                    }
                %>
            </table>
        </div>
    </body>
</html>
