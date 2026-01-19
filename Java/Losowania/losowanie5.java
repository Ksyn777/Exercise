package Losowania;
import java.util.Random;
import java.util.Scanner;
import java.util.Arrays;

class losowanie5 {
    public static boolean czyZawiera(int[] tablica, int liczba,int ileElementow)
    {
        for(int i = 0; i < ileElementow; i++)
            {
                if(tablica[i] == liczba)
                {
                    return true;
                }
            }
        return false;
    }
    public static boolean roznica(int[] pierwsza, int[] druga, int ilosc_elementow)
    {
        for(int i = 0; i < ilosc_elementow; i++)
        {
            if(pierwsza[i] != druga[i])
            {
                return false;
            }
        }
        return true;
    }
    public static void main(String[] args) {
        Random rand = new Random();
        Scanner scan = new Scanner(System.in);
        int[] podane = new int[6];
        for(int i = 0; i < 6; i++)
            {
                System.out.println("Podaj " + (i + 1) + " liczbe: ");
                int liczba = scan.nextInt();
                while(czyZawiera(podane, liczba, i))
                {
                    System.out.println("Ta liczba istnieje, podaj inną: ");
                    liczba = scan.nextInt();
                }
                podane[i] = liczba;     
            }
        Arrays.sort(podane);

        //LOSUJEMY LICZBY
        boolean czyRówne = false;
        int licznik_dni = 0;
        int[] wylosowane = new int[6];
        while(czyRówne != true)
        {
            int losowana;
            for(int l = 0; l < 6; l++)
            {
                losowana = rand.nextInt(49) + 1;
                while(czyZawiera(wylosowane, losowana, l))
                {
                    losowana = rand.nextInt(49) + 1;
                }
                wylosowane[l] = losowana;
            }
            Arrays.sort(wylosowane);
            czyRówne = roznica(podane, wylosowane, 6);
            licznik_dni++;
        }
        if(licznik_dni < 365)
        {
            System.out.println("Ilosc dni: " + licznik_dni);
        }
        else
        {
            int lata = licznik_dni / 365;
            int dni = licznik_dni % 365;
            System.out.println("Ilosc lat: " + lata);
            System.out.println("Ilosc dni: " + dni);
        }
        
        scan.close();  
    }
}