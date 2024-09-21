package com.swp391.koibe.dtos;

import lombok.Builder;
import lombok.Data;
import java.util.Map;

@Data
@Builder
public class UnsplashImageDTO {
    private String slug;
    private String description;
    private String alt_description;
    private Map<String, String> urls;
}
