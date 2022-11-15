package com.peczedavid.fogorvos.model.db;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "clinic_services")
public class ClinicService {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private Double cost;

    public static final String CLINIC_SERVICE_VIZSGALAT = "CLINIC_SERVICE_VIZSGALAT";
    public static final String CLINIC_SERVICE_RONTGEN = "CLINIC_SERVICE_RONTGEN";
    public static final String CLINIC_SERVICE_SZAKORVOSI_VIZSGALAT = "CLINIC_SERVICE_SZAKORVOSI_VIZSGALAT";
    public static final String CLINIC_SERVICE_FOGSZABALYZO_FELRAKASA = "CLINIC_SERVICE_FOGSZABALYZO_FELRAKASA";
}
