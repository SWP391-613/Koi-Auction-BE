package com.swp391.koibe.api;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@JsonPropertyOrder({
    "message",
    "data",
    "status_code",
    "is_success",
    "reason",
})
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
@Schema(description = "API Response")
public class ApiResponse<T> {
    @JsonProperty("status_code")
    protected Integer statusCode;

    @JsonProperty("message")
    @Schema(description = "Response message", example = "Login successfully")
    protected String message;

    @JsonProperty("reason")
    @Schema(description = "Reason of response", example = "User not found")
    protected String reason;

    @JsonProperty("is_success")
    @Schema(description = "Response status", example = "true")
    protected Boolean isSuccess;

    @JsonProperty("data")
    @Schema(description = "Response data")
    protected T data;

    public static <T> ApiResponseBuilder<T> builder() {
        return new ApiResponseBuilder<>();
    }

    public static class ApiResponseBuilder<T> {
        private Integer statusCode;
        private String message;
        private String reason;
        private Boolean isSuccess;
        private T data;

        ApiResponseBuilder() {
        }

        public ApiResponseBuilder<T> statusCode(Integer statusCode) {
            this.statusCode = statusCode;
            return this;
        }

        public ApiResponseBuilder<T> message(String message) {
            this.message = message;
            return this;
        }

        public ApiResponseBuilder<T> reason(String reason) {
            this.reason = reason;
            return this;
        }

        public ApiResponseBuilder<T> isSuccess(Boolean isSuccess) {
            this.isSuccess = isSuccess;
            return this;
        }

        public ApiResponseBuilder<T> data(T data) {
            this.data = data;
            return this;
        }

        public ApiResponse<T> build() {
            return new ApiResponse<>(statusCode, message, reason, isSuccess, data);
        }
    }
}