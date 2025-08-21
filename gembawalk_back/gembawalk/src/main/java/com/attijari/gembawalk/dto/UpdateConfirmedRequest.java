// UpdateConfirmedRequest.java
package com.attijari.gembawalk.dto;

public class UpdateConfirmedRequest {
    private Long responseId;
    private boolean confirmed;

    public Long getResponseId() { return responseId; }
    public void setResponseId(Long responseId) { this.responseId = responseId; }

    public boolean isConfirmed() { return confirmed; }
    public void setConfirmed(boolean confirmed) { this.confirmed = confirmed; }
}
