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
public class PaymentProcessResult {
    private Boolean success;
    private String transactionId;
    private String status;
    private BigDecimal amount;
    private String message;
    private String errorCode;
    private Long paymentId;
}
