package com.swp391.koibe.services.role;

import com.swp391.koibe.dtos.RoleDTO;
import com.swp391.koibe.models.Role;
import com.swp391.koibe.responses.RoleResponse;
import java.util.List;

public interface IRoleService {
    List<RoleResponse> getAllRoles();
    RoleResponse createRole(RoleDTO roleDTO);
    RoleResponse updateRole(long id, RoleDTO roleDTO);
    void deleteRole(Long id);
    RoleResponse getRoleById(Long id);
}
