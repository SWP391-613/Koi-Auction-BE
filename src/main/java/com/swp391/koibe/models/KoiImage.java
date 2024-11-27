package com.swp391.koibe.models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.*;

@Entity
@Table(name = "koi_images")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder

public class KoiImage {

    public static final int MAXIMUM_IMAGES_PER_PRODUCT = 6;

    @Id
    @SequenceGenerator(name = "koi_images_seq", sequenceName = "koi_images_id_seq", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "koi_images_seq")
    @Column(name="id", unique=true, nullable=false)
    @JsonProperty("id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "koi_id")
    @JsonIgnore
    private Koi koi;

    @Column(name = "image_url", length = 300)
    @JsonProperty("image_url")
    private String imageUrl;

    @Column(name = "video_url", length = 500)
    @JsonProperty("video_url")
    private String videoUrl;
}