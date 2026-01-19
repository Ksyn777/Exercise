import java.util.*;
import java.lang.*;
import java.io.*;
import java.util.Scanner;


class PoleKola {
    public static void main(String[] args) {
        Scanner scan = new Scanner(System.in);
        System.out.println("Podaj promień koła: ");
        Double r = scan.nextDouble();
        Double pole_kola = Math.PI * Math.pow(r, 2);
        System.out.println("Pole kola: " + pole_kola);
        scan.close();
    }
}