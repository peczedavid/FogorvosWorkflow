package com.peczedavid.fogorvos.repository;

import com.peczedavid.fogorvos.model.db.UsedClinicService;
import com.peczedavid.fogorvos.model.db.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface UsedClinicServiceRepository extends JpaRepository<UsedClinicService, Long> {

    List<UsedClinicService> findAllByUserAndProcessInstanceId(User user, String processInstanceId);
    @Transactional
    List<UsedClinicService> removeByProcessInstanceId(String processInstanceId);
}
