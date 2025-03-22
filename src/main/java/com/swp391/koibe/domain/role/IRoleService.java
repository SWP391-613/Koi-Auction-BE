package com.swp391.koibe.domain.role;

import java.util.List;

public interface IRoleService {
    List<RoleResponse> getAllRoles();
    RoleResponse createRole(RoleDTO roleDTO);
    RoleResponse updateRole(long id, RoleDTO roleDTO);
    void deleteRole(Long id);
    RoleResponse getRoleById(Long id);
}
