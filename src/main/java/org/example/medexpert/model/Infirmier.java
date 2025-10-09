package org.example.medexpert.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;

@Entity
@Table(name = "infirmiers")
public class Infirmier extends Utilisateur {

    private String service;

    public String getService() { return service; }
    public void setService(String service) { this.service = service; }
}
