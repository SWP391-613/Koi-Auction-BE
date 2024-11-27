package com.swp391.koibe.models;


import com.fasterxml.jackson.annotation.JsonProperty;
import com.swp391.koibe.enums.ProviderName;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "social_accounts")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class SocialAccount {

    @Id
    @SequenceGenerator(name = "social_accounts_seq", sequenceName = "social_accounts_id_seq", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "social_accounts_seq")
    @Column(name="id", unique=true, nullable=false)
    @JsonProperty("id")
    private Long id;

    @Column(name = "email", length = 150)
    private String email;

    @Column(name = "name")
    private String name;

    @Enumerated(EnumType.STRING)
    @Column(name = "provider_name")
    private ProviderName providerName;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

}