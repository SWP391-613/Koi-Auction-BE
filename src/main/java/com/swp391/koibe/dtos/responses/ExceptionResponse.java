package com.swp391.koibe.dtos.responses;

import com.swp391.koibe.api.BaseResponse;
import java.util.Map;
import lombok.experimental.SuperBuilder;

@SuperBuilder
public class ExceptionResponse extends BaseResponse<Object> {

    private Map<String, Object> details;

}
