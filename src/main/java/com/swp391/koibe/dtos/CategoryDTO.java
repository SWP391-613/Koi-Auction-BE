package com.swp391.koibe.dtos;

import jakarta.validation.constraints.NotEmpty;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class CategoryDTO {

    @NotEmpty(message = "Category name is required")
    private String name;

}