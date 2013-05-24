package controlador;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.accesodatos.Solicitud;
import modelo.accesodatos.Taxi;
import modelo.logicanegocio.FachadaDeSesion;

/**
 *
 * @author Grupo4
 */
@WebServlet(name = "ControladorServlet", urlPatterns = {"/ControladorServlet"})
public class ControladorServlet extends HttpServlet {

    @EJB
    FachadaDeSesion ejb;
    Taxi taxiOptimo;
    Solicitud solicitud;

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String peticion = request.getParameter("solicitud");

        //Sección para insertar una solicitud
        if (peticion.equals("crearSolicitud")) {

            //Se reciben los parámetros de la solicitud
            String nombre = request.getParameter("Nombre");
            String direccion = request.getParameter("Direccion");
            String telefono = request.getParameter("Telefono");
            //Insertar solicitud en la base de datos
            solicitud = ejb.insertarSolicitud(nombre, direccion, telefono);
            //Obtener Taxi para la solicitud
            Integer idTaxi = ejb.obtenerTaxi();//Parametro idSolicitud
            //Obtener información del taxi de la solicitud
            taxiOptimo = ejb.consultaInfoTaxi(idTaxi);

            //se agregan el taxi y la solicitud al request para que lo utilize la vista taxiOptimo.jsp
            request.setAttribute("taxi", taxiOptimo);
            request.setAttribute("solicitud", solicitud);
            //se envía la información a la vista
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/taxiOptimo.jsp");
            dispatcher.forward(request, response);

            //Sección para mostrar la información de la solicitud
        } /*else if (peticion.equals("mostrarMensaje")) {
            //Se reciben los parámetros de la solicitud
            String nombreCliente = (String) request.getParameter("nombreCliente");
            String destino = (String) request.getParameter("destino");
            String telefono = (String) request.getParameter("telefono");
            //Solicitud solicitud = new Solicitud(nombreCliente, destino, telefono, "10/10/2012");

            //Se agregan los parámetros al request para que sean utilizados por la vista mensaje.jsp
            request.setAttribute("telefono", telefono);
            request.setAttribute("nombreCliente", nombreCliente);
            request.setAttribute("destino", destino);
            //Se envía la información a la vista
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/mensaje.jsp");
            dispatcher.forward(request, response);

            //Sección para ver la información de un taxi
        }*/ else if (peticion.equals("infoTaxi")) {

            Integer idTaxi = Integer.parseInt(request.getParameter("id"));
            String direccion = request.getParameter("direccion");
            Taxi taxi = ejb.consultaInfoTaxi(idTaxi);
            request.setAttribute("taxi", taxi);

            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/infoTaxi.jsp");
            dispatcher.forward(request, response);
        } else if (peticion.equals("obtenerTaxis")) {
            //En esta sección, se obtiene la lista de todos los taxis y se envían 
            //a la vista listaTaxis.jsp

            //Lista que contiene los taxis. Es resultado de consultaListaTaxis de la fachadaDeSesion
            List<Integer> listaTaxis = ejb.consultaListaTaxis();
            //lista que contiene la información de todos los taxis
            ArrayList<Taxi> listaInfoTaxis = new ArrayList<Taxi>();
            for (int i = 0; i < listaTaxis.size(); i++) {
                //se añade a la lista la información de los taxis
                listaInfoTaxis.add(ejb.consultaInfoTaxi(listaTaxis.get(i)));
            }

            //Se añaden la lista de taxis y la lista de la información de los taxis
            request.setAttribute("infoTaxis", listaInfoTaxis);
            request.setAttribute("taxis", listaTaxis);
            //se manda la información a la vista
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/listaTaxis.jsp");
            dispatcher.forward(request, response);
        } else if (peticion.equals("enviarMensaje")) {
            //idsolicitud, idtaxi
            boolean exito = ejb.enviarMensaje(solicitud, taxiOptimo.getNumBastidor());
            if (exito) {
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/index.jsp");
                dispatcher.forward(request, response);
            }//else enviar a pagina para que vuelva a intentar
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
