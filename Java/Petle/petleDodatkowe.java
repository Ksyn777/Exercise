


class PetelDod {
    public static void main(String[] args) {
        for (int i = 1; i <= 100; i++) {
            String s2 = (i % 2 == 0) ? "podzielne przez 2 " : "";
            String s3 = (i % 3 == 0) ? "podzielne przez 3 " : "";
            String wynik = s2 + s3;

            if (wynik.isEmpty()) {
                System.out.println(i);
            } else {
                System.out.println(wynik);
            }
        }
    }
}