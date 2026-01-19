package Losowania;

import java.util.Random;
import java.util.Scanner;

class losowanie1 {
    public static void main(String[] args) {
        Random rand = new Random();
        Scanner scan = new Scanner(System.in);
        int wylosowana = rand.nextInt();
        int pobrana = -1;
        while(pobrana != wylosowana)
            {
                System.out.println("Podaj liczbe: ");
                pobrana = scan.nextInt();
                if(pobrana > wylosowana)
                {
                    System.out.println("Liczba za duża!");
                }
                else if(pobrana < wylosowana)
                {
                    System.out.println("Liczba za mała!");
                }
                else 
                {
                    System.out.println("Brawo! Odgadłeś liczbę.");
                }
            }
            scan.close();  
        
    }
}