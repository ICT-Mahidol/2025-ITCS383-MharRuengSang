package com.mharruengsang.service;

import com.mharruengsang.dto.PaymentRequestDTO;
import com.mharruengsang.entity.Payment;

public interface PaymentGatewayProvider {
    
    /**
     * Process credit card payment through the gateway
     */
    PaymentProcessResult processCardPayment(PaymentRequestDTO request, Payment payment);
    
    /**
     * Process bank transfer payment
     */
    BankTransferResult processBankTransfer(Payment payment);
    
    /**
     * Verify payment status with the gateway
     */
    PaymentVerificationResult verifyPayment(String transactionId);
    
    /**
     * Refund a payment
     */
    RefundResult refundPayment(String transactionId, java.math.BigDecimal amount);
}

@lombok.Data
@lombok.NoArgsConstructor
@lombok.AllArgsConstructor
class PaymentProcessResult {
    private boolean success;
    private String transactionId;
    private String message;
    private String errorCode;
}

@lombok.Data
@lombok.NoArgsConstructor
@lombok.AllArgsConstructor
class BankTransferResult {
    private boolean success;
    private String bankReferenceNumber;
    private String bankAccountDetails;
    private String message;
}

@lombok.Data
@lombok.NoArgsConstructor
@lombok.AllArgsConstructor
class PaymentVerificationResult {
    private boolean success;
    private Payment.PaymentStatus status;
    private String message;
}

@lombok.Data
@lombok.NoArgsConstructor
@lombok.AllArgsConstructor
class RefundResult {
    private boolean success;
    private String refundId;
    private String message;
}
