<%-- 
    Document   : testDescarga
    Created on : 29-may-2013, 13:13:32
    Author     : hero_arganda
--%>

<%@page import="controlador.ControladorServlet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet">    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        <style type="text/css">	
            #divDescargar{
                position:absolute;
                top:200px;
                left:36%;
            }
            #progressBar {
                width: 400px;
                height: 22px;
                border: 1px solid #111;
                background-color: #292929;
            }

            #progressBar div {
                height: 100%;
                color: #fff;
                text-align: right;
                line-height: 22px; /* same as #progressBar height if we want text middle aligned */
                width: 0;
                background-color: #0099ff;
            }

        </style>


        <script src="funciones.js"></script>
        <link rel="stylesheet" type="text/css" href="estilo.css"/>
        <script src="funciones.js"></script>
    </head>
    <body>
        <div id="encabezado">
            <div id="botonEncendidoIndex"></div>
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
                    <li><a href="index.jsp">Inicio</a></li>
                    <li id="comolink" onclick="obtenerTaxis();">| Ver Taxis |</li>
                    <li><a href="generarSolicitud.jsp">Crear Solicitud</a></li>
                </ul>
            </div>
        </div>
        <div id="divDescargar">
            <div id="progressBar" style="float: left; margin-right: 10px;"><div> </div></div> 
            <button id="guardar" type="button" class="btn btn-primary" style="float: left;display: none" > Guardar como</button>
            <div>
                <div id="solicitudes"> </div>
                <button id="descargar" class="btn btn-success" data-dismiss="modal" aria-hidden="true">Descargar</button>
                <button id="cancelar" class="btn" data-dismiss="modal" aria-hidden="true">Cancelar</button>
            </div>
            <div style="clear:both;"> </div>
        
        </div>
        
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script> 
        <script type="text/javascript" src="script.js"></script> 

    </body>
</html>
