package com.swp391_09.Koi_BE.controllers;

import com.github.javafaker.Faker;
import com.swp391_09.Koi_BE.dtos.KoiDTO;
import com.swp391_09.Koi_BE.enums.TrackingStatus;
import com.swp391_09.Koi_BE.models.Category;
import com.swp391_09.Koi_BE.models.Koi;
import com.swp391_09.Koi_BE.services.koi.IKoiService;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RequestMapping("${api.prefix}/kois")
@RestController
@RequiredArgsConstructor
public class KoiController {

    private final IKoiService koiService;

    @PostMapping("/generateFakeKois")
    private ResponseEntity<String> generateFakeKois() {
        Faker faker = new Faker();

        String[] genders = {"M", "F", "O", "U"};

        for (int i = 1; i < 100; i++) {
            String koiName = faker.animal().name();
            if(koiService.existsByName(koiName)) {
                continue;
            }
            KoiDTO koiDTO = KoiDTO.builder()
                .name(koiName)
                .price((float)faker.number().numberBetween(10, 90_000_000))
                .trackingStatus(TrackingStatus.getRandomStatus())
                .isDisplay(faker.number().numberBetween(0, 2))
                .isSold(faker.number().numberBetween(0, 2))
                .thumbnail(faker.internet().image())
                .sex(genders[faker.number().numberBetween(0, genders.length)])
                .length(faker.number().numberBetween(1, 100))
                .age(faker.number().numberBetween(1, 230))
                .description(faker.lorem().sentence())
                .categoryId(faker.number().numberBetween(1, 11)) //1-10 categories
                .build();
            try{
                koiService.createKoi(koiDTO);
            } catch (Exception e) {
                return ResponseEntity.badRequest().body(e.getMessage());
            }
        }
        return ResponseEntity.ok("Fake kois generated");
    }

    //pagination kois
    @GetMapping("")
    public ResponseEntity<List<Koi>> getAllKois(
        @RequestParam("page") int page,
        @RequestParam("limit") int limit
    ) {
        try{
            PageRequest pageRequest = PageRequest.of(page, limit);
            Page<Koi> categories = koiService.getAllKois(pageRequest);
            return ResponseEntity.ok(categories.getContent());
        }catch (Exception e){
            return ResponseEntity.badRequest().body(null);
        }
    }



}
