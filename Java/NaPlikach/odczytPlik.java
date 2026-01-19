package NaPlikach;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class odczytPlik {
    public static void main(String[] args) {
        try {
            List<String> wszystkieLinie = Files.readAllLines(Paths.get("napis.TXT"));

            Set<String> unikalne = new HashSet<>();
            Set<String> powtorzone = new HashSet<>();

            for (String napis : wszystkieLinie) {
                if (!unikalne.add(napis)) {
                    powtorzone.add(napis);
                }
            }

            System.out.println("Napisy występujące więcej niż raz:");
            for (String s : powtorzone) {
                System.out.println(s);
            }

        } catch (IOException e) {
            System.err.println("Błąd pliku: " + e.getMessage());
        }
    }
}