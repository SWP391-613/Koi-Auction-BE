package com.swp391.koibe.domain.role;

import com.swp391.koibe.dtos.RoleDTO;
import com.swp391.koibe.dtos.responses.RoleResponse;
import java.util.List;

public interface IRoleService {
    List<RoleResponse> getAllRoles();
    RoleResponse createRole(RoleDTO roleDTO);
    RoleResponse updateRole(long id, RoleDTO roleDTO);
    void deleteRole(Long id);
    RoleResponse getRoleById(Long id);
}
