package org.example.medexpert.model;

import jakarta.persistence.*;
import org.example.medexpert.model.enums.TypeActe;

@Entity
@Table(name = "actes_medicaux")
public class ActeMedical {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    @Column(name = "type_acte", nullable = false)
    private TypeActe typeActe;

    @Column(nullable = false)
    private Double cout;

    public ActeMedical() {}

    public ActeMedical(TypeActe typeActe, Double cout) {
        this.typeActe = typeActe;
        this.cout = cout;
    }

    public Long getId() {
        return id;
    }

    public TypeActe getTypeActe() {
        return typeActe;
    }

    public void setTypeActe(TypeActe typeActe) {
        this.typeActe = typeActe;
    }

    public Double getCout() {
        return cout;
    }

    public void setCout(Double cout) {
        this.cout = cout;
    }

    @Override
    public String toString() {
        return "ActeMedical{" +
                "id=" + id +
                ", typeActe=" + typeActe +
                ", cout=" + cout +
                '}';
    }
}
