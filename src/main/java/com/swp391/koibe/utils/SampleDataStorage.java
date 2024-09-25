package com.swp391.koibe.utils;

import com.swp391.koibe.enums.EKoiStatus;
import java.util.Arrays;
import java.util.List;
import lombok.Getter;

public class SampleDataStorage {

    @Getter
    public static class Koi {

        String[] genders = {"M", "F", "O", "U"};

        EKoiStatus[] koiStatusList = EKoiStatus.values();

        List<String>  koiNames = Arrays.asList(
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

    }

    //others sample data here

}