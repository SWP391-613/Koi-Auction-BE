package com.swp391_09.Koi_BE.services;

import com.swp391_09.Koi_BE.repositories.VerifyStatusRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class VerifyStatusService implements IVerifyStatusService {

    private final VerifyStatusRepository verifyStatusRepository;

}
