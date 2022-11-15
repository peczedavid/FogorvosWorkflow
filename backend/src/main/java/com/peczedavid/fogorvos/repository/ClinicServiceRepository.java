package com.peczedavid.fogorvos.repository;

import com.peczedavid.fogorvos.model.db.ClinicService;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ClinicServiceRepository extends JpaRepository<ClinicService, Long> {

    Optional<ClinicService> findByName(String name);

}