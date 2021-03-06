package modelo.logicanegocio;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import modelo.accesodatos.Solicitud;
import modelo.accesodatos.Taxi;

/**
 *
 * @author Grupo 4
 */
@Stateless
public class FachadaDeSesion {

    @PersistenceContext
    private EntityManager em;
    private List<Solicitud> listaSolicitudes;

    public List<Integer> consultaListaTaxis() {
        List<Integer> listaTaxis;
        //Devuelve la lista de identificadores de los taxis de la BBDD
        listaTaxis = (List<Integer>) em.createNamedQuery("Taxi.findAllByNumBastidor").getResultList();
        return listaTaxis;
    }

    public String consultaEstadoTaxi(Integer idTaxi) {
        //Devuelve el estado del taxi
        return (String) em.createNamedQuery("Taxi.findEstadoByNumBastidor").
                setParameter("numBastidor", idTaxi).getSingleResult();
    }

    public Taxi consultaInfoTaxi(Integer idTaxi) {
        //Devuelve el taxi con la información de estado, ubicacion y destino
        return (Taxi) em.createNamedQuery("Taxi.findByNumBastidor").
                setParameter("numBastidor", idTaxi).getSingleResult();
    }

    public Solicitud insertarSolicitud(String nombre, String direccion, String telefono) {
        //Inserta la solicitud en la BBDD
        Date fecha = new Date();
        Solicitud solicitud = new Solicitud(nombre, direccion, telefono, fecha.toString());
        em.persist(solicitud);

        return solicitud;
    }

    public Integer obtenerTaxi() {

        //Obtiene los taxis que han atendido alguna solicitud
        List<Taxi> listaSolicitudes = em.createNamedQuery("Solicitud.findTaxis").getResultList();
        int numSolicitudes = listaSolicitudes.size();

        //Obtiene la lista de taxis que disponemos
        List<Integer> listaTaxis = consultaListaTaxis();
        int numTaxis = listaTaxis.size();

        //Taxi al que se le va a enviar el mensaje
        Integer taxiCandidato = null;
        Integer taxiOptimo = null;

        boolean libre;
        int i;

        //En caso de que haya algun taxi en la BBDD
        if ((numTaxis > 0) && (numSolicitudes == 0)) {
            //Si aun no se ha antendido ninguna solicitud devuelve el primer taxi libre
            i = 0;
            libre = false;
            while (i < numTaxis && !libre) {
                taxiCandidato = listaTaxis.get(i);
                if (consultaEstadoTaxi(taxiCandidato).equalsIgnoreCase("disponible")) {
                    libre = true;
                    taxiOptimo = taxiCandidato;
                } else {
                    i++;
                }
            }
            //En caso de que no encuentre ningun taxi disponible
            if (libre == false) {
                taxiOptimo = null;
            }

        } else if ((numTaxis > 0) && (numSolicitudes > 0)) {
            //Genera una lista ordenada por el tiempo de espera de los taxis
            ArrayList<Integer> taxisCandidatos = new ArrayList<Integer>();
            taxisCandidatos = generarCandidatos(numTaxis, listaSolicitudes, taxisCandidatos);

            libre = false;
            if (taxisCandidatos.size() < numTaxis) {
                //En caso de que no esten todos los taxis de los que se dispone lo busca
                i = 0;
                while (i < numTaxis && taxisCandidatos.size() < numTaxis && !libre) {
                    taxiCandidato = listaTaxis.get(i);
                    //Busca el taxi que no haya atendido ninguna solicitud y este libre
                    if (!estaEnLista(taxisCandidatos, taxiCandidato) && (consultaEstadoTaxi(taxiCandidato).equals("disponible"))) {
                        libre = true;
                        taxiOptimo = taxiCandidato;
                    } else {
                        i++;
                    }
                }
            } else {
                //Obtiene el primer taxi disponible
                i = taxisCandidatos.size() - 1;
                while (i >= 0 && !libre) {
                    taxiCandidato = listaTaxis.get(i);
                    if (consultaEstadoTaxi(taxiCandidato).equalsIgnoreCase("disponible")) {
                        libre = true;
                        taxiOptimo = taxiCandidato;
                    } else {
                        i--;
                    }
                }
            }
        }

        return taxiOptimo;
    }

    public boolean enviarMensaje(Solicitud solicitud, Integer idTaxi) {
        //Envia un mensaje al taxi indicado con la solicitud asignada

        //Obtiene el taxi
        Taxi taxi = (Taxi) em.createNamedQuery("Taxi.findByNumBastidor").setParameter("numBastidor", idTaxi).getResultList().get(0);

        boolean respuesta = recibirConfirmacion();

        if (respuesta) {
            //Asigna el taxi a la solicitud
            solicitud.setTaxiNumBastidor(taxi);

            //Actualiza la información del taxi
            taxi.setEstado("ocupado");
            taxi.setDestino(solicitud.getDireccionDestino());

            //Actualiza la BD
            em.merge(solicitud);
            em.merge(taxi);
        }


        return respuesta;
    }

    //Metodo para simular la recepcion del mensaje
    public boolean recibirConfirmacion() {
        return Math.random() < 0.5;
    }

    //Devuelve el numero de solicitudes
    public Integer getTotalSolicitudes() {
        listaSolicitudes = em.createNamedQuery("Solicitud.findAll").getResultList();
        //Comprobamos si la lista esta vacia.
        return listaSolicitudes == null ? 0 : listaSolicitudes.size();
    }

    //Devuelve la n-esima solicitud
    public Solicitud getSolicitud(Integer n) {
        Solicitud solicitud;
        //En caso de que no haya solicitudes o el indice no sea correcto.
        if ((listaSolicitudes == null) || (listaSolicitudes.isEmpty())
                || (n >= listaSolicitudes.size()) || (n < 0)) {
            solicitud = null;
        } //Si es la ultima solicitud
        else if (n == listaSolicitudes.size() - 1) {
            solicitud = listaSolicitudes.get(n);
            //Eliminamos la asignacion.
            listaSolicitudes = null;
        } else {
            solicitud = listaSolicitudes.get(n);
        }
        return solicitud;
    }

    //Genera la lista de los ultimos taxis que han atendido solicitudes
    private ArrayList<Integer> generarCandidatos(int numTaxis, List<Taxi> listaSolicitudes, ArrayList<Integer> taxisCandidatos) {
        int numSolicitudes = listaSolicitudes.size();
        Integer taxiCandidato;

        while (numTaxis > 0 && numSolicitudes > 0) {
            taxiCandidato = listaSolicitudes.get(numSolicitudes - 1).getNumBastidor();
            //Añade el taxi si no esta repetido
            if ((!estaEnLista(taxisCandidatos, taxiCandidato)) && (consultaEstadoTaxi(taxiCandidato).equalsIgnoreCase("disponible"))) {
                taxisCandidatos.add(taxiCandidato);
            }
            numTaxis--;
            numSolicitudes--;
        }
        return taxisCandidatos;
    }

    //Comprueba si ya esta en la lista
    private boolean estaEnLista(ArrayList lista, int id) {
        boolean encontrado = false;
        if (!lista.isEmpty()) {
            for (int i = 0; i < lista.size() - 1; i++) {
                if (id == lista.get(i)) {
                    encontrado = true;
                }
            }
        }
        return encontrado;
    }
}