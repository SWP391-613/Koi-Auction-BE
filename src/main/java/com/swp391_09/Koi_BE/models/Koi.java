package com.swp391_09.Koi_BE.models;

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

    private Float price;

    @Column(name = "thumbnail", length = 300)
    private String thumbnail;

    @Column(name = "description")
    private String description;

    @ManyToOne
    @JoinColumn(name = "category_id")
    private Category category;

    @OneToMany(mappedBy = "koi",
        cascade = CascadeType.ALL,
        fetch = FetchType.LAZY)
    private List<KoiImage> koiImages;

}