package Losowania;
import java.util.Random;


class losowanie4 {
    public static void main(String[] args) {
        Random rand = new Random();
        int[] wylosowane = new int[6];
        int licznik = 0;

        while (licznik < wylosowane.length) {
            int nowaLiczba = rand.nextInt(49) + 1; 
            boolean powtorka = false;
            for (int i = 0; i < licznik; i++) {
                if (wylosowane[i] == nowaLiczba) {
                    powtorka = true;
                    break; 
                }
            }

            if (!powtorka) {
                wylosowane[licznik] = nowaLiczba;
                licznik++;
                }
        }
        for (int liczba : wylosowane) {
            System.out.println(liczba);
        }
               
    }
}