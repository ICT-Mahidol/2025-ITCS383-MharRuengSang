package com.mharruengsang.service.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class BankTransferResult {
    private Boolean success;
    private String referenceNumber;
    private String accountNumber;
    private String bankName;
    private String message;
    private String errorCode;
}
