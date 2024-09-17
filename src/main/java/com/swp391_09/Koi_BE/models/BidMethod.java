package com.swp391_09.Koi_BE.models;

import com.swp391_09.Koi_BE.enums.EBidMethod;
import jakarta.persistence.*;
import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Builder
@Entity
@Table(name = "bid_methods")
public class BidMethod {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "name")
    @Enumerated(EnumType.STRING)
    private EBidMethod name;

}
