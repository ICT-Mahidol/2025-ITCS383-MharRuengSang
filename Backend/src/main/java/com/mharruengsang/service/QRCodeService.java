package com.mharruengsang.service;

import java.util.Base64;

public interface QRCodeService {
    
    /**
     * Generate PromptPay QR code for the given phone number and amount
     */
    QRCodeResult generatePromptPayQR(String phoneNumber, java.math.BigDecimal amount, String orderId);
    
    /**
     * Generate static PromptPay QR code (no specific amount)
     */
    QRCodeResult generateStaticPromptPayQR(String phoneNumber);
}

@lombok.Data
@lombok.NoArgsConstructor
@lombok.AllArgsConstructor
class QRCodeResult {
    private boolean success;
    private String qrCodeBase64; // Base64 encoded PNG
    private String qrCodeData; // Raw QR code data/string
    private String message;
    private String errorCode;
}
