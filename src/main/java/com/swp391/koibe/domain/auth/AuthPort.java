package com.swp391.koibe.domain.auth;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.swp391.koibe.domain.token.TokenPort.TokenResponse;

public interface AuthPort {

    @JsonInclude(Include.NON_NULL)
    record LoginResponse(
        TokenResponse token
    ) {}

}
