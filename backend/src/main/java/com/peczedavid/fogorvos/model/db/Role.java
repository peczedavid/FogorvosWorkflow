package com.peczedavid.fogorvos.model.db;

import lombok.*;

import javax.persistence.*;

@Data
@RequiredArgsConstructor
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "roles")
public class Role {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NonNull
    @Column(nullable = false, unique = true)
    private String name;

    public static final String ROLE_USER = "ROLE_USER";
    public static final String ROLE_RECEPTIONIST = "ROLE_RECEPTIONIST";
    public static final String ROLE_ADMIN = "ROLE_ADMIN";

}
