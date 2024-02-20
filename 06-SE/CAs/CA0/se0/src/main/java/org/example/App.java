package org.example;

import com.opencsv.CSVReader;

import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

public class App {
    private static ArrayList<Player> players = new ArrayList<>();
    public static void main(String[] args){
        Date date = new Date(18,11,1402);
        System.out.println(date.nextDay());
        readCSV("src\\main\\java\\org\\example\\input.csv");
        Player Gholam = getPlayer("Gholam");
        System.out.println(Gholam.getTeamMembershipDays("Golgohar"));
    }
    private static ArrayList<Player> readCSV(String filename){
        try (CSVReader reader = new CSVReader(new FileReader(filename))) {
            String[] nextLine;
            while ((nextLine = reader.readNext()) != null) {
                Player player = getPlayer(nextLine[0]);
                if (player == null){
                    player = new Player(nextLine[0]);
                }
                Date dateStart = new Date(Integer.parseInt(nextLine[2]) ,  Integer.parseInt(nextLine[3]), Integer.parseInt(nextLine[4])); //day month year
                Date dateEnd = new Date(Integer.parseInt(nextLine[5]) ,  Integer.parseInt(nextLine[6]), Integer.parseInt(nextLine[7])); //day month year
                Membership membership = new Membership(nextLine[1], dateStart, dateEnd);
                player.addMembership(membership);
                players.add(player);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return players;
    }

    private static Player getPlayer(String playerWanted ){
        for (Player player :  players ){
            if(player.getPlayerName().equals(playerWanted)){
                return player;

            }
        }
        return null;
    }
}
