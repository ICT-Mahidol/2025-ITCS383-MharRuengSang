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
public class RefundResult {
    private Boolean success;
    private String refundId;
    private String originalTransactionId;
    private BigDecimal refundAmount;
    private String status;
    private String message;
    private String errorCode;
}
