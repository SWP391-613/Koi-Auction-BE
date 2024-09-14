package com.swp391_09.Koi_BE.services.role;

import com.swp391_09.Koi_BE.models.Role;
import com.swp391_09.Koi_BE.repositories.RoleRepository;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class RoleService implements IRoleService{
    private final RoleRepository roleRepository;
    @Override
    public List<Role> getAllRoles() {
        return roleRepository.findAll();
    }
}
