package com.swp391_09.Koi_BE.dtos;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserLoginDTO {

    @JsonProperty("email")
    private String email;

    @NotNull(message = "Password can not be empty")
    @JsonProperty("password")
    private String password;

}
