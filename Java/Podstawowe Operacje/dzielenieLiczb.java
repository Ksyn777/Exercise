import java.util.*;
import java.lang.*;
import java.io.*;
import java.util.Scanner;

class DzielenieLiczb {
    public static void main(String[] args) {
        Scanner scan = new Scanner(System.in);
        System.out.println("Podaj pierwszą liczbę: ");
        int a = scan.nextInt();
        System.out.println("Podaj drugą liczbę: ");
        int b = scan.nextInt();
        int result = a / b;
        int reszta = a % b;
        System.out.println("Wynik dzielenia: " + result);
        System.out.println("Reszta dzielenia: " + reszta);
        scan.close();
        
    }

}
