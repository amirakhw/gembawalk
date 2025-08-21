package com.attijari.gembawalk.dto;

public class DashboardStatsDto {

    private long totalVisit;
    private long visiteActive;
    private long visitNonActive;

    public DashboardStatsDto() {
    }

    public DashboardStatsDto(long totalVisit, long visiteActive, long visitNonActive) {
        this.totalVisit = totalVisit;
        this.visiteActive = visiteActive;
        this.visitNonActive = visitNonActive;
    }

    public long getTotalVisit() {
        return totalVisit;
    }

    public void setTotalVisit(long totalVisit) {
        this.totalVisit = totalVisit;
    }

    public long getVisiteActive() {
        return visiteActive;
    }

    public void setVisiteActive(long visiteActive) {
        this.visiteActive = visiteActive;
    }

    public long getVisitNonActive() {
        return visitNonActive;
    }

    public void setVisitNonActive(long visitNonActive) {
        this.visitNonActive = visitNonActive;
    }


}
