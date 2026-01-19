package Losowania;

import java.util.Random;
import java.util.Scanner;


class losowanie2 {
    public static void main(String[] args) {
        Random rand = new Random();
        Scanner scan = new Scanner(System.in);
        System.out.println("Podaj minimum: ");
        int minimum = scan.nextInt();
        System.out.println("Podaj maksimum: ");
        int maksimum = scan.nextInt();
        int wylosowana = rand.nextInt(maksimum - minimum + 1) + minimum;
        System.out.println("Wylosowana: " + wylosowana);
        scan.close(); 
    }
}