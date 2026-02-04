#include <boost/asio.hpp>
#include <iostream>
#include <string>
#include <thread>

using boost::asio::ip::tcp;
using namespace std;

int main() {
    try {
        boost::asio::io_context io;

        //Tworzy obiekt gniazda,
        tcp::socket socket(io);
        //"Książka telefoniczna". Pozwala zamienić nazwę domenową
        tcp::resolver resolver(io);

        // Szuka adresu IP 127.0.0.1 na porcie 9000.
        auto endpoints = resolver.resolve("127.0.0.1", "9000");
        //Próba nawiązania fizycznego połączenia z serwerem.
        boost::asio::connect(socket, endpoints);
        cout << "Polaczono z serwerem!\n";

        string nick;
        cout << "Podaj swoj nick: ";
        getline(cin, nick);
        //Dodaje znak nowej linii, aby serwer wiedział, gdzie kończy się imię.
        nick += "\n"; 
        //Wysyła Twój nick do serwera zaraz po połączeniu.
        boost::asio::write(socket, boost::asio::buffer(nick));

        // Tworzy nowy wątek. Symbol [&socket] oznacza, że wątek ma dostęp do naszego gniazda przez referencję.
        thread reader([&socket]() {
            try {
                char reply[1024];
                while (true) {
                    boost::system::error_code error;
                    //Czeka na dane. Jeśli ktoś inny coś napisze na czacie, serwer nam to prześle, a ta linijka to przechwyci.
                    size_t len = socket.read_some(boost::asio::buffer(reply), error);

                    //Jeśli serwer zostanie wyłączony, ten warunek to wykryje i zamknie pętlę.
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

        
        string message;
        while (true) {
            cout << "> ";
            getline(cin, message);

            if (message == "exit") break;

            message += "\n";
            boost::system::error_code error;
            //Wysyła wiadomość do serwera, który następnie roześle ją do reszty ludzi.
            boost::asio::write(socket, boost::asio::buffer(message), error);

            if (error) {
                cout << "Blad wysylania: " << error.message() << endl;
                break;
            }
        }

        //Informuje serwer: "Wychodzę, zamykamy połączenie".
        socket.close();
        //Czeka, aż wątek odbierający dane zakończy swoją pracę
        reader.join();

        cout << "Czat zakonczony.\n";

    } catch (exception& e) {
        cout << "Wyjatek: " << e.what() << endl;
    }

    return 0;
}
