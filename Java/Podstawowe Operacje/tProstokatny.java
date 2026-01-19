import java.util.*;
import java.lang.*;
import java.io.*;
import java.util.Scanner;

class prosty {
    public static void main(String[] args) {
        System.out.println("Podaj trzy boki: ");
        Scanner scan = new Scanner(System.in);
        int a = scan.nextInt();
        int b = scan.nextInt();
        int c = scan.nextInt();
        double check = Math.pow(a, 2) + Math.pow(b, 2);
        System.out.println(
        check == Math.pow(c, 2)
        ? "Można utworzyć trójkąt prostokątny"
        : "Nie można utworzyć trójkąta prostokątnego"
        );
        scan.close();
    }
}