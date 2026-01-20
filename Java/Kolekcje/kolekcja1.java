package Kolekcje;
import java.util.*;

class kolekcja1 {
    public static void main(String[] args) {
        Random rand = new Random();
        Scanner scan = new Scanner(System.in);

        Set<Integer> zestawUzytkownikaSet = new HashSet<>();
        
        System.out.println("Podaj 6 unikalnych liczb z zakresu 1-49:");
        while (zestawUzytkownikaSet.size() < 6) {
            System.out.print("Liczba " + (zestawUzytkownikaSet.size() + 1) + ": ");
            
            if (scan.hasNextInt()) {
                int liczba = scan.nextInt();
                if (liczba >= 1 && liczba <= 49) {
                    if (!zestawUzytkownikaSet.add(liczba)) {
                        System.out.println("Ta liczba już została podana!");
                    }
                } else {
                    System.out.println("Liczba musi być z zakresu 1-49!");
                }
            } else {
                System.out.println("To nie jest liczba!");
                scan.next(); 
            }
        }

        List<Integer> podanePosortowane = new ArrayList<>(zestawUzytkownikaSet);
        Collections.sort(podanePosortowane);

        long licznikDni = 0;
        List<Integer> wylosowane = new ArrayList<>();
        boolean czyTrafiono = false;

        System.out.println("\nRozpoczynam losowania... to może chwilę potrwać.");

        while (!czyTrafiono) {
            wylosowane.clear();
            Set<Integer> losowanieDnia = new HashSet<>();

            while (losowanieDnia.size() < 6) {
                losowanieDnia.add(rand.nextInt(49) + 1);
            }
            wylosowane.addAll(losowanieDnia);
            Collections.sort(wylosowane);

            licznikDni++;

            if (podanePosortowane.equals(wylosowane)) {
                czyTrafiono = true;
            }
        }

        long lata = licznikDni / 365;
        long dni = licznikDni % 365;

        System.out.println("Zajęło to: " + lata + " lat i " + dni + " dni.");
        System.out.println("Łączna liczba losowań: " + licznikDni);

        scan.close();
    }
}