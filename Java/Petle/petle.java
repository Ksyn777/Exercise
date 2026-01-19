import java.util.*;
import java.util.Scanner;
import java.util.Arrays;



class Petle {
    public static void main(String[] args) {
        //Wyświetl liczby od 1 do 10
        for(int i = 1; i <= 10; i++)
            {
                System.out.println(i);
            }

        //Wyświetl liczby od 5 do 10
       for(int i = 5; i <= 10; i++)
            {
                System.out.println(i);
            }

        //Wyświetl liczby od 10 do 1
        for(int i = 10; i >= 1; i--)
            {
                System.out.println(i);
            }

        //Wyświetl liczby od 1 do 100 podzielne bez reszty:
        List<Integer> przez_trzy = new ArrayList<>();
        List<Integer> przez_piec = new ArrayList<>();
        List<Integer> przez_trzy_piec = new ArrayList<>();
        List<Integer> przez_trzy_bez_piec = new ArrayList<>();

        for (int i = 1; i <= 100; i++) {

            if (i % 3 == 0 && i % 5 == 0) {
                przez_trzy_piec.add(i);
            } 
            else if (i % 3 == 0) {
                przez_trzy.add(i);
            } 
            else if (i % 5 == 0) {
                przez_piec.add(i);
            } 
            else if (i % 3 == 0 && i % 5 != 0) {
                przez_trzy_bez_piec.add(i);
            }
        }

        System.out.println("Podzielne przez 3:");
        for (int x : przez_trzy) {
            System.out.println(x);
        }

        System.out.println("\nPodzielne przez 5:");
        for (int x : przez_piec) {
            System.out.println(x);
        }

        System.out.println("\nPodzielne przez 3 i 5:");
        for (int x : przez_trzy_piec) {
            System.out.println(x);
        }

        System.out.println("\nPodzielne przez 3 ale nie przez 5:");
        for (int x : przez_trzy_bez_piec) {
            System.out.println(x);
       }

        //Wyświetl liczby w pętli z przedziału podanego przez użytkownika
        Scanner scan = new Scanner(System.in);
        System.out.println("Podaj poczatek przedziału: ");
        int start = scan.nextInt();
        System.out.println("Podaj koniec przedziału: ");
        int finish = scan.nextInt();
        for(int i = start; i <= finish; i++)
            {
                System.out.println(i);
            }

        //Wyświetl tabliczkę mnożenia (w wierszach i kolumnach 1..10 x 1..10)
        for(int i = 1; i <= 10; i++)
            {
                for(int j = 1; j <= 10; j++)
                    {
                        int wynik = i * j;
                        System.out.println(i + " * " + j + " = " + wynik);
                    }
            }

        //Wyświetl kolejne elementy ciągu Fibonacciego.
        List<Integer> ciag_fib = new ArrayList<>(Arrays.asList(0, 1));
        int f_kolejny;
        for(int i = 0; i <= 46; i++)
            {
                f_kolejny = ciag_fib.get(i) + ciag_fib.get(i + 1);
                ciag_fib.add(f_kolejny);
            }
        for(int x : ciag_fib)
            {
                System.out.println(x);
            }

       scan.close(); 
    }
}