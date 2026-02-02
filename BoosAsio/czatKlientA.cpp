#include <boost/asio.hpp>
#include <iostream>
#include <string>
#include <thread>

using boost::asio::ip::tcp;
using namespace std;

int main() {
    try {
        boost::asio::io_context io;

        // 1️⃣ Tworzymy socket i resolver
        tcp::socket socket(io);
        tcp::resolver resolver(io);

        // 2️⃣ Rozwiązujemy adres serwera i łączymy się
        auto endpoints = resolver.resolve("127.0.0.1", "9000");
        boost::asio::connect(socket, endpoints);
        cout << "Polaczono z serwerem!\n";

        // 3️⃣ Podanie nicku
        string nick;
        cout << "Podaj swoj nick: ";
        getline(cin, nick);
        nick += "\n"; // znak końca linii
        boost::asio::write(socket, boost::asio::buffer(nick));

        // 4️⃣ Wątek do odbioru wiadomości w tle
        thread reader([&socket]() {
            try {
                char reply[1024];
                while (true) {
                    boost::system::error_code error;
                    size_t len = socket.read_some(boost::asio::buffer(reply), error);

                    if (error == boost::asio::error::eof) {
                        // Serwer zamknął połączenie
                        cout << "\nSerwer zakończył połączenie.\n";
                        break;
                    } else if (error) {
                        // Inny błąd sieciowy
                        cout << "\nBlad odczytu: " << error.message() << endl;
                        break;
                    }

                    if (len > 0) {
                        cout << "\n" << string(reply, len) << "\n> ";
                        cout.flush();
                    }
                }
            } catch (exception& e) {
                cout << "\nWyjatek w watku odbioru: " << e.what() << endl;
            }
        });

        // 5️⃣ Pętla wysyłania wiadomości
        string message;
        while (true) {
            cout << "> ";
            getline(cin, message);

            if (message == "exit") break;

            message += "\n";
            boost::system::error_code error;
            boost::asio::write(socket, boost::asio::buffer(message), error);

            if (error) {
                cout << "Blad wysylania: " << error.message() << endl;
                break;
            }
        }

        // 6️⃣ Zamykanie połączenia i wątku
        socket.close();
        reader.join();

        cout << "Czat zakonczony.\n";

    } catch (exception& e) {
        cout << "Wyjatek: " << e.what() << endl;
    }

    return 0;
}
