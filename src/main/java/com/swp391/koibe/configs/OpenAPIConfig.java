package com.swp391.koibe.configs;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.ExternalDocumentation;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import io.swagger.v3.oas.models.media.BooleanSchema;
import io.swagger.v3.oas.models.media.IntegerSchema;
import io.swagger.v3.oas.models.media.Schema;
import io.swagger.v3.oas.models.media.StringSchema;
import io.swagger.v3.oas.models.security.SecurityRequirement;
import io.swagger.v3.oas.models.security.SecurityScheme;
import io.swagger.v3.oas.models.servers.Server;
import org.springdoc.core.models.GroupedOpenApi;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class OpenAPIConfig {

    @Bean
    public OpenAPI customOpenAPI() {
        return new OpenAPI()
            .info(new Info()
                      .title("Koi Auction API Services")
                      .version("1.0.0")
                      .description("REST API documentation for Koi Auction services")
                      .contact(new Contact()
                                   .name("Your Team Name")
                                   .email("team@example.com"))
                      .license(new License()
                                   .name("Private License")))
            .externalDocs(new ExternalDocumentation()
                              .description("API Documentation")
                              .url("https://your-docs-url.com"))
            .addSecurityItem(new SecurityRequirement().addList("JavaInUseSecurityScheme"))
            .components(
                new Components()
                    .addSecuritySchemes("JavaInUseSecurityScheme",
                                        new SecurityScheme()
                                            .name("JavaInUseSecurityScheme")
                                            .type(SecurityScheme.Type.HTTP)
                                            .scheme("bearer")
                                            .bearerFormat("JWT")
                                            .description("Please enter JWT token"))
                    .addSchemas("ApiResponse", createApiResponseSchema())
                    .addSchemas("ApiErrorResponse", createApiErrorResponseSchema()))
            .addServersItem(new Server().url("/").description("Local server"));
    }

    private Schema<?> createApiResponseSchema() {
        Schema<?> schema = new Schema<>()
            .type("object")
            .description("Standard API response wrapper");

        schema.setProperties(new java.util.HashMap<>() {{
            put("message", new StringSchema().example("Operation successful"));
            put("reason", new StringSchema().example("The operation completed successfully"));
            put("statusCode", new IntegerSchema().example(200));
            put("isSuccess", new BooleanSchema().example(true));
            put("data",
                new Schema<>().type("object").description("Response payload - varies by endpoint"));
        }});

        return schema;
    }

    private Schema<?> createApiErrorResponseSchema() {
        Schema<?> schema = new Schema<>()
            .type("object")
            .description("Error response wrapper");

        schema.setProperties(new java.util.HashMap<>() {{
            put("message", new StringSchema().example("Error message"));
            put("reason", new StringSchema().example("Detailed error reason"));
            put("status_code", new IntegerSchema().example(400));
            put("is_success", new BooleanSchema().example(false));
        }});

        return schema;
    }

    @Bean
    public GroupedOpenApi publicApi() {
        return GroupedOpenApi.builder()
            .group("public")
            .pathsToMatch("/**") // Ensure you're matching the correct paths
            .build();
    }
}