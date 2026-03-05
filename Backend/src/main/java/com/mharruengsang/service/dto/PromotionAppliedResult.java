package com.mharruengsang.service.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PromotionAppliedResult {
    private Boolean success;
    private String promCode;
    private BigDecimal discountAmount;
    private BigDecimal finalPrice;
    private String message;
    private String errorCode;
}
