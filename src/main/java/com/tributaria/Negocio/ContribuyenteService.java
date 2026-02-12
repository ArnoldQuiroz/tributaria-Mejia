package com.tributaria.Negocio;

import com.tributaria.dao.PersonaDAO;
import com.tributaria.dao.ContribuyenteDAO;
import com.tributaria.model.Persona;

public class ContribuyenteService {

    public String registrarContribuyente(String nombres, String apellidos,
                                         String razonSocial, int tipoPersona) throws Exception {

        Persona p = new Persona();
        p.setNombres(nombres);
        p.setApellidos(apellidos);

        // Si es persona natural → razon social queda null
        if (tipoPersona == 1) {
            p.setRazonSocial(null);
        } else {
            p.setRazonSocial(razonSocial);
        }

        p.setTipoPersonaId(tipoPersona);

        PersonaDAO pdao = new PersonaDAO();
        long idPersona = pdao.insertar(p);

        if (idPersona <= 0) {
            throw new Exception("No se pudo registrar la persona.");
        }

        // Generar código de contribuyente
        String codigo = generarCodigoContribuyente(idPersona);

        ContribuyenteDAO cdao = new ContribuyenteDAO();
        cdao.insertar(idPersona, codigo);

        return codigo;
    }

    private String generarCodigoContribuyente(long id) {
        return "C-" + String.format("%06d", id);
    }
}
