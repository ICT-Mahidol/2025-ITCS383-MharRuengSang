package com.mharruengsang.service;

import java.util.List;

public interface GeolocationService {
    
    /**
     * Calculate distance between two coordinates in kilometers
     */
    Double calculateDistance(Double lat1, Double lng1, Double lat2, Double lng2);
    
    /**
     * Find nearby riders within specified radius
     */
    List<NearbyRiderInfo> findNearbyRiders(Double customerLat, Double customerLng, Double radiusKm, String riderStatus);
}

@lombok.Data
@lombok.NoArgsConstructor
@lombok.AllArgsConstructor
class NearbyRiderInfo {
    private Long riderId;
    private String riderName;
    private Double latitude;
    private Double longitude;
    private Double distanceKm;
    private Double estimatedArrivalMinutes;
    private Double riderRating;
}
