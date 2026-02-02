#include <boost/asio.hpp>
#include <iostream>
#include <vector>
#include <thread>
#include <memory>

using boost::asio::ip::tcp;
using namespace std;

struct Client {
    string nick;
    shared_ptr<tcp::socket> socket;
};

vector<Client> clients;
boost::asio::io_context io;

void handle_client(Client client) {
    try {
        char data[1024];
        while (true) {
            //Obiekt, który przechowa informację, czy operacja czytania się udała
            boost::system::error_code error;
            //Próba odczytania danych z gniazda (socketu). Program zatrzymuje się tu i czeka, aż klient coś wyśle.
            size_t len = client.socket->read_some(boost::asio::buffer(data), error);

            //Jeśli błąd to eof (End Of File), oznacza to, że klient zamknął aplikację. Przerywamy pętlę.
            if (error == boost::asio::error::eof) {
                cout << client.nick << " rozlaczony.\n";
                break;
            //Jeśli wystąpił jakikolwiek inny błąd sieciowy, wypisujemy go i kończymy obsługę.
            } else if (error) {
                cout << "Blad klienta " << client.nick << ": " << error.message() << endl;
                break;
            }

            //Zamiana surowych bajtów z bufora na obiekt typu string o długości len
            string message(data, len);
            //Doklejenie nicku nadawcy do treści wiadomości.
            string formatted = client.nick + ": " + message;

            // wyslij do wszystkich pozostalych klientow
            for (auto& c : clients) {
                //Sprawdzenie, aby nie wysyłać wiadomości z powrotem do osoby, która ją napisała.
                if (c.socket != client.socket) {
                    //Wysłanie sformatowanej wiadomości do gniazda innego klienta.
                    boost::asio::write(*c.socket, boost::asio::buffer(formatted));
                }
            }
        }
    //Złapanie i wypisanie ewentualnych wyjątków standardowych.
    } catch (exception& e) {
        cout << "Wyjatek klienta " << client.nick << ": " << e.what() << endl;
    }
}

int main() {
    tcp::acceptor acceptor(io, tcp::endpoint(tcp::v4(), 9000));
    cout << "Serwer nasluchuje na porcie 9000...\n";

    //Główna pętla serwera akceptująca nowych klientów.
    while (true) {
        //Stworzenie nowego, „inteligentnego” wskaźnika na gniazdo dla przyszłego klienta.
        auto sock = make_shared<tcp::socket>(io);
        //Program zatrzymuje się tutaj i czeka, aż ktoś spróbuje się połączyć. 
        //Gdy to nastąpi, sock zostaje powiązany z tym połączeniem.
        acceptor.accept(*sock);

        // odczytaj nick
        char buffer[256];
        //Odczytanie nicku od klienta zaraz po połączeniu.
        size_t len = sock->read_some(boost::asio::buffer(buffer));
        //Konwersja odebranego nicku na tekst.
        string nick(buffer, len);

        //Stworzenie struktury/obiektu klienta łączącego nick z jego socketem.
        Client client{nick, sock};
        clients.push_back(client);
        cout << "Polaczono klienta: " << nick << endl;

        // uruchom watek dla tego klienta
        thread t(handle_client, client);
        //Odłączenie wątku. Serwer nie musi czekać, aż wątek się skończy
        t.detach();
    }

    return 0;
}
