package org.example;

import java.time.temporal.ChronoUnit;
import java.util.Objects;

public class Membership {
    private final String teamName;
    private final Date startDate;
    private final Date endDate;

    public Membership(String teamName, Date startDate, Date endDate) {
        if (teamName == null || teamName.isEmpty()) {
            throw new IllegalArgumentException("Invalid team name");
        }
        if (startDate == null || endDate == null || endDate.compareTo(startDate) < 0) {
            throw new IllegalArgumentException("Invalid start or end date");
        }

        this.teamName = teamName;
        this.startDate = startDate;
        this.endDate = endDate;
    }
    
    public boolean overlapsWith(Membership otherMembership) {
        return this.startDate.compareTo(otherMembership.getEndDate()) <= 0
                && this.endDate.compareTo(otherMembership.getStartDate()) >= 0;
    }

    public long getMembershipDuration() {
        Date i = this.startDate;
        int count = 0;
        while(i.compareTo(this.endDate) <= 0){
            count++;
            i = i.nextDay();
        }
        return count;
    }
    
    public String getTeamName() {
        return teamName;
    }
    
    public Date getStartDate() {
        return startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null && getClass() != o.getClass()) return false;
        Membership that = (Membership) o;
        return teamName.equals(that.teamName) && startDate.equals(that.startDate) && endDate.equals(that.endDate);
    }

    @Override
    public int hashCode() {
        return Objects.hash(teamName, startDate, endDate);
    }
}