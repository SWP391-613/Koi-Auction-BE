package com.swp391.koibe

import com.swp391.koibe.utils.openHomePage
import org.springframework.boot.SpringApplication
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.cache.annotation.EnableCaching
import org.springframework.data.jpa.repository.config.EnableJpaRepositories
import org.springframework.retry.annotation.EnableRetry
import java.util.*

@SpringBootApplication
@EnableCaching
@EnableRetry
@EnableJpaRepositories(basePackages = ["com.swp391.koibe.repositories"])
open class KoiBeApplication

fun main(args: Array<String>) {
    TimeZone.setDefault(TimeZone.getTimeZone("Asia/Ho_Chi_Minh"))
    SpringApplication.run(KoiBeApplication::class.java, *args)
    openHomePage("http://localhost:8080/swagger-ui/index.html")
}