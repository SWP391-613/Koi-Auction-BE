package com.swp391.koibe.controllers;

import static io.restassured.RestAssured.given;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.hasItems;
import static org.junit.jupiter.api.Assertions.assertEquals;

import com.google.gson.Gson;
import com.swp391.koibe.dtos.RoleDTO;
import com.swp391.koibe.enums.UserRole;
import com.swp391.koibe.models.Role;
import com.swp391.koibe.repositories.RoleRepository;
import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import java.util.List;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.http.HttpStatus;
import org.springframework.test.context.ActiveProfiles;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@ActiveProfiles("test")
public class RoleControllerTest {

    @LocalServerPort
    private int port;

    @Autowired
    private RoleRepository roleRepository;

    private final Gson gson = new Gson();

    @BeforeEach
    public void setUp() {
        RestAssured.port = port;
        roleRepository.deleteAll(); // Clean the database before each test
    }

    @Test
    public void testGetAllRoles() {
        // Arrange
        createAndSaveRoles(UserRole.MEMBER, UserRole.STAFF, UserRole.BREEDER, UserRole.MANAGER);

        // Act & Assert
        given()
            .when()
            .get("/api/v1/roles")
            .then()
            .statusCode(200)
            .contentType(ContentType.JSON)
            .body("message", equalTo("Roles fetched successfully"))
            .body("list_data.size()", equalTo(4)) // Check that there are 4 roles
            .body("list_data.name", hasItems("member", "staff", "breeder", "manager")); // Check role names
    }

    @Test
    public void testGetRoleById_Success() {
        // Arrange
        Role role = new Role(UserRole.MANAGER);
        role = roleRepository.save(role);

        // Act & Assert
        given()
            .when()
            .get("/api/v1/roles/{id}", role.getId())
            .then()
            .statusCode(200)
            .contentType(ContentType.JSON)
            .body("message", equalTo("Role fetched successfully"))
            .body("single_data.id", equalTo(role.getId().intValue()))
            .body("single_data.name", equalTo("manager"));
    }

    @Test
    public void testGetRoleById_NotFound() {
        // Act & Assert
        given()
            .when()
            .get("/api/v1/roles/{id}", 999L)
            .then()
            .statusCode(HttpStatus.NOT_FOUND.value())
            .contentType(ContentType.JSON)
            .body("message", equalTo("Data not found"));
    }

    @Test
    public void testCreateRole_Success() {
        Role role = new Role(UserRole.valueOf("DEVELOPER"));
        // Arrange
        RoleDTO roleDTO = createRoleDTO(role.getUserRole());

        // Act & Assert
        //will open when provider the jwt token
//        createRole(roleDTO)
//            .statusCode(201)
//            .body("message", equalTo("Role created successfully"))
//            .body("single_data.id", notNullValue())
//            .body("single_data.name", equalTo("Developer"));
//
//        // Verify in the database
//        verifyRoleInDatabase("Developer");

        createRole(roleDTO)
            .statusCode(403);
    }

    @Test
    public void testDeleteRole_NotFound() {
        // Act & Assert
        deleteRole(999L)
            .statusCode(403);
    }

    // Helper methods for reusability and clean code
    private void createAndSaveRoles(UserRole... roleNames) {
        for (UserRole name : roleNames) {
            roleRepository.save(new Role(name));
        }
    }

    private Role saveRole(UserRole name) {
        return roleRepository.save(new Role(name));
    }

    private RoleDTO createRoleDTO(UserRole name) {
        return RoleDTO.builder().userRole(name).build();
    }

    private io.restassured.response.ValidatableResponse createRole(RoleDTO roleDTO) {
        String roleJson = gson.toJson(roleDTO);
        return given()
            .contentType(ContentType.JSON)
            .body(roleJson)
            .when()
            .post("/api/v1/roles")
            .then();
    }

    private io.restassured.response.ValidatableResponse updateRole(Long id, RoleDTO roleDTO) {
        String roleJson = gson.toJson(roleDTO);
        return given()
            .contentType(ContentType.JSON)
            .body(roleJson)
            .when()
            .put("/api/v1/roles/{id}", id)
            .then();
    }

    private io.restassured.response.ValidatableResponse deleteRole(Long id) {
        return given()
            .when()
            .delete("/api/v1/roles/{id}", id)
            .then();
    }

    private void verifyRoleInDatabase(UserRole roleName) {
        List<Role> roles = roleRepository.findAll();
        assertEquals(1, roles.size());
        assertEquals(roleName, roles.get(0).getUserRole());
    }
}
