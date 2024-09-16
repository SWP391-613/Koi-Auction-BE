package com.swp391_09.Koi_BE.models;

import com.swp391_09.Koi_BE.enums.KoiTrackingStatus;
import jakarta.persistence.*;
import lombok.*;


@Entity
@Table(name = "tracking_status")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class TrackingStatus {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.ORDINAL)
    @Column(name = "name")
    private KoiTrackingStatus name;

}
