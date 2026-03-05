package com.mharruengsang.service.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class QRCodeResult {
    private Boolean success;
    private String qrImageBase64;
    private String rawData;
    private String message;
    private String errorCode;
}
