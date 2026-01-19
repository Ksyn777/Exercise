import java.util.*;
import java.lang.*;
import java.io.*;
import java.util.Scanner;

class Delta {
    public static void main(String[] args) {
        System.out.println("Podaj trzy liczby");
        Scanner scan = new Scanner(System.in);
        int a = scan.nextInt();
        int b = scan.nextInt();
        int c = scan.nextInt();
        double delta = Math.pow(b, 2) - 4 * a * c;
        if (a == 0) {
            System.out.println("To nie jest równanie kwadratowe!");
            return;
        }
        
        if(delta > 0)
        {
            double x_one = (-b - Math.sqrt(delta)) / 2 * a;
            System.out.println("X1: " + x_one);
            double x_two = (-b + Math.sqrt(delta)) / 2 * a;
            System.out.println("X2: " + x_two);
            System.out.println("Ma dwa rozwiązania");
        }
        else if(delta == 0)
        {
            int x = -b / (2 * a);
            System.out.println("Jedno rozwiąznie");
            System.out.println("X: " + x);
        }
        else
        {
            System.out.println("Brak rozwiązań!");
        }
        scan.close();
    }
}