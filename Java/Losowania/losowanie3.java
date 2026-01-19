package Losowania;
import java.util.Random;

class losowanie3 {
    public static void main(String[] args) {
        Random rand = new Random();
        int [] wylosowane = new int[6];
        for(int i = 0; i < 6; i++)
            {
                int wylosowana = rand.nextInt(50);
                wylosowane[i] = wylosowana;
            }
        for (int liczba : wylosowane) {
            System.out.println(liczba);
        }
               
    }
}