package com.swp391_09.Koi_BE.services;

import com.swp391_09.Koi_BE.repositories.BidMethodRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class BidMethodService {

    private final BidMethodRepository bidMethodRepository;

}
