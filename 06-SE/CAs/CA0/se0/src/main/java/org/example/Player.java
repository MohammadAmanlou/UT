package org.example;

import java.util.ArrayList;
import java.util.List;

public class Player {
    private final String playerName;
    private final ArrayList<Membership> membershipHistory;

    public Player(String playerName) {
        this.playerName = playerName;
        this.membershipHistory = new ArrayList<>();
    }

    public void addMembership(Membership newMembership) {
        // Check for overlap with existing memberships
        for (Membership existingMembership : membershipHistory) {
            if (newMembership.overlapsWith(existingMembership)) {
                throw new IllegalArgumentException("Overlap with existing membership");
            }
        }
        // No overlap, add the new membership to the history
        membershipHistory.add(newMembership);
    }

    public long getTeamMembershipDays(String teamName) {
        return membershipHistory.stream()
                .filter(membership -> membership.getTeamName().equals(teamName))
                .mapToLong(membership -> membership.getMembershipDuration())
                .sum();
    }

    public String getPlayerName() {
        return playerName;
    }

    public ArrayList<Membership> getMembershipHistory() {
        return membershipHistory;
    }



    // Other getters and setters as needed
}