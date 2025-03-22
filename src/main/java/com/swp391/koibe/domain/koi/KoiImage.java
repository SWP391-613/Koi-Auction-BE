package com.swp391.koibe.domain.koi;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.swp391.koibe.metadata.MediaMeta;
import jakarta.persistence.*;
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

    @Embedded
    @JsonProperty("metadata")
    private MediaMeta mediaMeta;
}