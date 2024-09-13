package com.swp391_09.Koi_BE.controllers;

import com.swp391_09.Koi_BE.repositories.ShipperRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("${api.prefix}/shippers")
@RequiredArgsConstructor
public class ShipperController {

    private final ShipperRepository shipperRepository;

    @GetMapping("")
    public ResponseEntity<?> getAllShippers() {
        return ResponseEntity.ok(shipperRepository.findAll());
    }

}
