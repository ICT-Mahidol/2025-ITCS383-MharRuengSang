package com.mharruengsang.service.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class NearbyRiderInfo {
    private Long riderId;
    private String name;
    private Double latitude;
    private Double longitude;
    private Double distance;
    private String status;
    private String riderPhone;
    private Double averageRating;
    private Integer estimatedETA; // in minutes
}
