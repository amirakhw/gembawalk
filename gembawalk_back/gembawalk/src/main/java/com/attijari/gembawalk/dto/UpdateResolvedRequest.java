// UpdateResolvedRequest.java
package com.attijari.gembawalk.dto;

public class UpdateResolvedRequest {
    private Long responseId;
    private boolean resolved;

    public Long getResponseId() { return responseId; }
    public void setResponseId(Long responseId) { this.responseId = responseId; }

    public boolean isResolved() { return resolved; }
    public void setResolved(boolean resolved) { this.resolved = resolved; }
}
