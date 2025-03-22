package com.swp391.koibe.domain.asset;

import lombok.Builder;
import java.util.Map;

@Builder
public record UnsplashImageDTO (
    String slug,
    String description,
    String alt_description,
    Map<String, String> urls
){}
