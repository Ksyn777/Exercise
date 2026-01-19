import java.util.*;
import java.lang.*;
import java.io.*;
import java.util.Scanner;


class trojkat {
    public static void main(String[] args) {
        System.out.println("Podaj trzy boki: ");
        Scanner scan = new Scanner(System.in);
        int a = scan.nextInt();
        int b = scan.nextInt();
        int c = scan.nextInt();
        int suma_dwoch =  b + c;
        if(suma_dwoch <= a)
        {
            System.out.println("Nie można utworzyć trójkąta");
        }
        else
        {
            System.out.println("Można utworzyć trójkąta");
        }
        scan.close();
        
    }
}