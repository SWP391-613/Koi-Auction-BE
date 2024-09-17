package com.swp391_09.Koi_BE.services;

import com.swp391_09.Koi_BE.models.BidMethod;
import java.util.List;

public interface IBidMethodService {
    BidMethod createBidMethod(int id, String method);
    void updateBidMethod(int id, String method);
    void deleteBidMethod(int id);
    BidMethod getBidMethod(int id);
    List<BidMethod> getAllBidMethod();
}
