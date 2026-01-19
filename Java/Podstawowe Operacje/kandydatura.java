import java.util.*;
import java.lang.*;
import java.io.*;
import java.util.Scanner;

class kandydatura {
    public static void main(String[] args) {
        System.out.println("Ile masz lat ? : ");
        Scanner scan = new Scanner(System.in);
        int wiek = scan.nextInt();
        if(wiek >= 18)
        {
            if(wiek >= 35)
            {
                System.out.println("Możesz kandydować na prezydenta państwa");
            }
            else
            {
                System.out.println("Możesz głosować, ale nie możesz zostać wybranym na prezydenta");
            }
        }
        else
        {
            System.out.println("Nie możesz głosować");
        }
        scan.close();
    }
}