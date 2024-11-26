package com.swp391.koibe.exceptions;

import com.swp391.koibe.components.LocalizationUtils;
import com.swp391.koibe.exceptions.base.DataAlreadyExistException;
import com.swp391.koibe.exceptions.base.DataNotFoundException;
import com.swp391.koibe.exceptions.base.DataWrongFormatException;
import com.swp391.koibe.responses.ExceptionResponse;
import com.swp391.koibe.responses.base.ApiError;
import com.swp391.koibe.responses.base.BaseResponse;
import com.swp391.koibe.utils.MessageKey;
import java.util.HashMap;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.ServletWebRequest;
import org.springframework.web.context.request.WebRequest;

@Slf4j
@RestControllerAdvice
@RequiredArgsConstructor
public class GlobalExceptionHandler {

    private final LocalizationUtils localizationUtils;

    @ExceptionHandler(DataNotFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public ApiError<Object> handleDataNotFoundException(DataNotFoundException e) {
        return ApiError.errorBuilder()
                .message(localizationUtils.getLocalizedMessage(MessageKey.DATA_NOT_FOUND))
                .reason(e.getMessage())
                .statusCode(HttpStatus.NOT_FOUND.value())
                .isSuccess(false)
                .build();
    }

    @ExceptionHandler(NullPointerException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ApiError<Object> handleNullPointerException(NullPointerException e) {
        return ApiError.errorBuilder()
            .message(localizationUtils.getLocalizedMessage(MessageKey.EXCEPTION_NULL_POINTER))
            .reason(e.getMessage())
            .statusCode(HttpStatus.BAD_REQUEST.value())
            .isSuccess(false)
            .build();
    }

    @ExceptionHandler(BiddingRuleException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ApiError<Object> handleBiddingRuleException(BiddingRuleException e) {
        return ApiError.errorBuilder()
            .message(localizationUtils.getLocalizedMessage(MessageKey.BIDDING_RULE_EXCEPTION))
            .reason(e.getMessage())
            .statusCode(HttpStatus.BAD_REQUEST.value())
            .isSuccess(false)
            .build();
    }

    @ExceptionHandler(Exception.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ApiError<Object> handleException(Exception e) {
        log.error("Internal server error: ", e);
        return ApiError.errorBuilder()
            .message(localizationUtils.getLocalizedMessage(MessageKey.INTERNAL_SERVER_ERROR))
            .reason(e.getMessage())
            .statusCode(HttpStatus.INTERNAL_SERVER_ERROR.value())
            .isSuccess(false)
            .build();
    }

    @ExceptionHandler(GenerateDataException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public BaseResponse<Object> handleGenerateDataException(GenerateDataException e) {
        return ExceptionResponse.builder()
                .message(localizationUtils.getLocalizedMessage("exception.generate_data_error"))
                .reason(e.getMessage())
                .build();
    }

//    @ExceptionHandler(DataAlreadyExistException.class)
//    @ResponseStatus(HttpStatus.BAD_REQUEST)
//    public BaseResponse<Object> handleDataAlreadyExistsException(DataAlreadyExistException e) {
//        return ExceptionResponse.builder()
//                .message(localizationUtils.getLocalizedMessage("exception.data_already_exist"))
//                .reason(e.getMessage())
//                .build();
//    }

    @ExceptionHandler(InvalidApiPathVariableException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ApiError<Object> handleInvalidApiPathVariableException(InvalidApiPathVariableException e) {
        return ApiError.errorBuilder()
            .message(localizationUtils.getLocalizedMessage(MessageKey.EXCEPTION_INVALID_API_PATH_VARIABLE))
            .reason(e.getMessage())
            .statusCode(HttpStatus.BAD_REQUEST.value())
            .isSuccess(false)
            .build();
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    @ResponseBody
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ResponseEntity<Map<String, String>> handleValidationExceptions(
            MethodArgumentNotValidException ex) {
        Map<String, String> errors = new HashMap<>();
        ex.getBindingResult().getAllErrors().forEach((error) -> {
            String fieldName = ((FieldError) error).getField();
            String errorMessage = error.getDefaultMessage();
            errors.put(fieldName, errorMessage);
        });
        return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(DeleteException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public  ApiError<Object> handleDeleteException(DeleteException e) {
        return ApiError.errorBuilder()
            .message(localizationUtils.getLocalizedMessage(MessageKey.EXCEPTION_DELETE_ERROR))
            .reason(e.getMessage())
            .statusCode(HttpStatus.BAD_REQUEST.value())
            .isSuccess(false)
            .build();
    }

    @ExceptionHandler(MalformDataException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ApiError<Object> handleMalformDataException(MalformDataException e) {
        return ApiError.errorBuilder()
            .message(localizationUtils.getLocalizedMessage(MessageKey.EXCEPTION_MALFORMED_DATA))
            .reason(e.getMessage())
            .statusCode(HttpStatus.BAD_REQUEST.value())
            .isSuccess(false)
            .build();
    }

    @ExceptionHandler(MalformBehaviourException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ApiError<Object> handleMalformBehaviourException(MalformBehaviourException e) {
        return ApiError.errorBuilder()
            .message(localizationUtils.getLocalizedMessage(MessageKey.EXCEPTION_MALFORMED_BEHAVIOUR))
            .reason(e.getMessage())
            .statusCode(HttpStatus.BAD_REQUEST.value())
            .isSuccess(false)
            .build();
    }

    @ExceptionHandler(JwtAuthenticationException.class)
    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    @ResponseBody
    public ResponseEntity<Object> handleJwtAuthenticationException(JwtAuthenticationException ex, WebRequest request) {
        Map<String, Object> body = new HashMap<>();
        body.put("timestamp", System.currentTimeMillis());
        body.put("status", HttpStatus.UNAUTHORIZED.value());
        body.put("error", "Unauthorized");
        body.put("message", ex.getMessage());
        body.put("path", ((ServletWebRequest) request).getRequest().getRequestURI());
        return new ResponseEntity<>(body, HttpStatus.UNAUTHORIZED);
    }

    @ExceptionHandler(PermissionDeniedException.class)
    @ResponseStatus(HttpStatus.FORBIDDEN)
    public ApiError<Object> handlePermissionDeniedException(PermissionDeniedException e) {
        return ApiError.errorBuilder()
            .message(localizationUtils.getLocalizedMessage(MessageKey.EXCEPTION_PERMISSION_DENIED))
            .reason(e.getMessage())
            .statusCode(HttpStatus.FORBIDDEN.value())
            .isSuccess(false)
            .build();
    }

    @ExceptionHandler(KoiRevokeException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ApiError<Object> handleKoiRevokeException(KoiRevokeException e) {
        return ApiError.errorBuilder()
            .message(localizationUtils.getLocalizedMessage(MessageKey.EXCEPTION_KOI_REVOKE))
            .reason(e.getMessage())
            .statusCode(HttpStatus.BAD_REQUEST.value())
            .isSuccess(false)
            .build();
    }

    @ExceptionHandler(BadCredentialsException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ApiError<Object> handleBadCredentialsException(BadCredentialsException e) {
        return ApiError.errorBuilder()
            .message(localizationUtils.getLocalizedMessage(MessageKey.EXCEPTION_BAD_CREDENTIALS))
            .reason(e.getMessage())
            .statusCode(HttpStatus.BAD_REQUEST.value())
            .isSuccess(false)
            .build();
    }

    @ExceptionHandler(FeedbackResponseException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ApiError<Object> handleFeedBackResponseException(FeedbackResponseException e) {
        return ApiError.errorBuilder()
            .message(localizationUtils.getLocalizedMessage(MessageKey.FEEDBACK_EXCEPTION))
            .reason(e.getMessage())
            .statusCode(HttpStatus.BAD_REQUEST.value())
            .isSuccess(false)
            .build();
    }

    @ExceptionHandler(DataWrongFormatException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ApiError<Object> handlePasswordWrongFormatException(DataWrongFormatException e) {
        return ApiError.errorBuilder()
            .message(localizationUtils.getLocalizedMessage(MessageKey.WRONG_FORMAT))
            .reason(e.getMessage())
            .statusCode(HttpStatus.BAD_REQUEST.value())
            .isSuccess(false)
            .build();
    }

    @ExceptionHandler({DataIntegrityViolationException.class, DataAlreadyExistException.class})
    @ResponseStatus(HttpStatus.CONFLICT)
    public ApiError<Object> handleDataIntegrityViolationException(DataIntegrityViolationException e) {
        return ApiError.errorBuilder()
            .message(localizationUtils.getLocalizedMessage(MessageKey.EXCEPTION_DATA_INTEGRITY_VIOLATION))
            .reason(e.getMessage())
            .statusCode(HttpStatus.CONFLICT.value())
            .isSuccess(false)
            .build();
    }

}
