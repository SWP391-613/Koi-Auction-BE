package com.swp391_09.Koi_BE.models;

import com.swp391_09.Koi_BE.enums.TrackingStatus;
import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Table(name = "kois")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Koi extends BaseEntity{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name", nullable = false, length = 350)
    private String name;

    @Column(name = "price")
    private Float price;

    @Enumerated(EnumType.ORDINAL)
    @Column(name="tracking_status")
    private TrackingStatus trackingStatus;

    @Column(name = "is_display")
    private int isDisplay;

    @Column(name = "is_sold")
    private int isSold;

    @Column(name = "thumbnail", length = 300)
    private String thumbnail;

    @Column(name = "sex", length = 10)
    private String sex;

    @Column(name = "length")
    private int length;

    @Column(name= "age")
    private int age;

    @Column(name = "description")
    private String description;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user; //koi breeder

    @ManyToOne
    @JoinColumn(name = "category_id")
    private Category category;

    @OneToMany(mappedBy = "koi",
        cascade = CascadeType.ALL,
        fetch = FetchType.LAZY)
    private List<KoiImage> koiImages;

}