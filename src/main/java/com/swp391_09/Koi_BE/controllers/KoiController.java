package com.swp391_09.Koi_BE.controllers;

import com.github.javafaker.Faker;
import com.swp391_09.Koi_BE.dtos.KoiDTO;
import com.swp391_09.Koi_BE.enums.EKoiStatus;
import com.swp391_09.Koi_BE.models.Koi;
import com.swp391_09.Koi_BE.services.koi.IKoiService;
import java.util.Arrays;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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

        List<String> koiNames = Arrays.asList(
            "Kohaku", "Sanke", "Showa", "Tancho", "Shusui", "Asagi", "Bekko",
            "Utsurimono", "Goshiki", "Kumonryu", "Ochiba", "Koromo", "Yamabuki",
            "Doitsu", "Chagoi", "Ki Utsuri", "Beni Kikokuryu", "Platinum Ogon",
            "Hariwake", "Kikokuryu", "Matsuba", "Ginrin Kohaku", "Ginrin Sanke",
            "Ginrin Showa", "Doitsu Kohaku", "Doitsu Sanke", "Doitsu Showa",
            "Aka Matsuba", "Kage Shiro Utsuri", "Kin Showa", "Orenji Ogon",
            "Kikusui", "Ki Bekko", "Hikari Muji", "Hikari Utsuri", "Benigoi",
            "Soragoi", "Midorigoi", "Ginrin Chagoi", "Kanoko Kohaku",
            "Kanoko Sanke", "Kanoko Showa", "Kujaku", "Doitsu Kujaku",
            "Yamatonishiki", "Budo Sanke", "Ai Goromo", "Sumi Goromo",
            "Kin Ki Utsuri", "Gin Shiro Utsuri"
        );

        String[] genders = {"M", "F", "O", "U"};

        EKoiStatus[] koiStatusList = EKoiStatus.values();

        for (int i = 1; i < 300; i++) {
            String koiName = koiNames.get(faker.number().numberBetween(0, koiNames.size()));
//            if(koiService.existsByName(koiName)) {
//                continue;
//            }
            KoiDTO koiDTO = KoiDTO.builder()
                .name(koiName)
                .price((float)faker.number().numberBetween(10, 90_000_000))
                .EKoiStatus(koiStatusList[faker.number().numberBetween(0, koiStatusList.length)])
                .isDisplay(faker.number().numberBetween(0, 2))
                .thumbnail("https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/48/photos/Sanke%2040cm.png")
                .sex(genders[faker.number().numberBetween(0, genders.length)])
                .length(faker.number().numberBetween(1, 100))
                .age(faker.number().numberBetween(1, 231)) //1-230
                .description(faker.lorem().sentence())
                .ownerId((long) faker.number().numberBetween(1, 4)) //userId from 1-3
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
    @GetMapping("") //kois/?page=0&limit=10
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
