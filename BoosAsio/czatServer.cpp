#include <boost/asio.hpp>
#include <iostream>
#include <vector>
#include <thread>
#include <memory>
#include <mutex>
#include <algorithm>

using boost::asio::ip::tcp;
using namespace std;

// Struktura przechowująca dane klienta
struct Client {
    string nick;
    shared_ptr<tcp::socket> socket;
    string room;
};

// Globalne zmienne
vector<Client> clients;
mutex clients_mutex;
boost::asio::io_context io;

// Funkcja usuwająca klienta z listy po rozłączeniu
void remove_client(shared_ptr<tcp::socket> socket) {
    lock_guard<mutex> lock(clients_mutex);
    clients.erase(remove_if(clients.begin(), clients.end(),
        [&socket](const Client& c) { return c.socket == socket; }),
        clients.end());
}

void handle_client(Client client) {
    try {
        char data[1024];
        while (true) {
            boost::system::error_code error;
            // Oczekiwanie na dane od klienta
            size_t len = client.socket->read_some(boost::asio::buffer(data), error);

            if (error == boost::asio::error::eof) {
                cout << "[System] " << client.nick << " rozlaczony.\n";
                break;
            } else if (error) {
                cout << "[Blad] " << client.nick << ": " << error.message() << endl;
                break;
            }

            string message(data, len);
            // Usuwanie znaków nowej linii z odebranej wiadomości dla łatwiejszego parsowania
            message.erase(remove(message.begin(), message.end(), '\n'), message.end());
            message.erase(remove(message.begin(), message.end(), '\r'), message.end());

            // KOMENDA: /join <pokoj>
            if (message.substr(0, 6) == "/join ") {
                string new_room = message.substr(6);
                
                lock_guard<mutex> lock(clients_mutex);
                for (auto& c : clients) {
                    if (c.socket == client.socket) {
                        c.room = new_room;
                        client.room = new_room; // Aktualizacja lokalnej kopii
                        break;
                    }
                }
                string system_msg = "Serwer: Jestes teraz w pokoju: " + new_room + "\n";
                boost::asio::write(*client.socket, boost::asio::buffer(system_msg));
                continue;
            }

            // KOMENDA: /who
            if (message == "/who") {
                string list_msg = "Osoby w pokoju [" + client.room + "]: ";
                {
                    lock_guard<mutex> lock(clients_mutex);
                    for (auto& c : clients) {
                        if (c.room == client.room) list_msg += c.nick + " ";
                    }
                }
                list_msg += "\n";
                boost::asio::write(*client.socket, boost::asio::buffer(list_msg));
                continue;
            }

            // KOMENDA: /lobby
            if(message == "/lobby")
            {
                string old_room = client.room;
                string new_room = "lobby";
                {
                    lock_guard<mutex> lock(clients_mutex);
                    for (auto& c : clients) {
                        if (c.socket == client.socket) {
                            c.room = new_room;
                            client.room = new_room; // Aktualizacja lokalnej kopii wątku
                            break;
                        }
                    }
                }
                string system_msg = "Serwer: Wrociles do lobby.\n";
                boost::asio::write(*client.socket, boost::asio::buffer(system_msg));

                string leave_notify = "[System] " + client.nick + " opuscil pokoj i wrocil do lobby.\n";
                lock_guard<mutex> lock(clients_mutex);
                for (auto& c : clients) {
                    if (c.room == old_room && c.socket != client.socket) {
                        boost::system::error_code ec;
                        boost::asio::write(*c.socket, boost::asio::buffer(leave_notify), ec);
                    }
                }
                continue;
            }

            // ZWYKŁA WIADOMOŚĆ - Wysyłka do osób w tym samym pokoju
            string formatted = "[" + client.room + "] " + client.nick + ": " + message + "\n";
            {
                lock_guard<mutex> lock(clients_mutex);
                for (auto& c : clients) {
                    // Nie wysyłaj do siebie i sprawdzaj pokój
                    if (c.socket != client.socket && c.room == client.room) {
                        boost::system::error_code err;
                        boost::asio::write(*c.socket, boost::asio::buffer(formatted), err);
                    }
                }
            }
        }
    } catch (exception& e) {
        cout << "[Wyjatek] " << client.nick << ": " << e.what() << endl;
    }

    // Sprzątanie po wyjściu z pętli
    remove_client(client.socket);
}

int main() {
    try {
        tcp::acceptor acceptor(io, tcp::endpoint(tcp::v4(), 9000));
        cout << "Serwer czatu uruchomiony na porcie 9000...\n";

        while (true) {
            auto sock = make_shared<tcp::socket>(io);
            acceptor.accept(*sock);

            // Pierwsza wiadomość od klienta to jego nick
            char buffer[256];
            size_t len = sock->read_some(boost::asio::buffer(buffer));
            string nick(buffer, len);
            nick.erase(remove(nick.begin(), nick.end(), '\n'), nick.end());
            nick.erase(remove(nick.begin(), nick.end(), '\r'), nick.end());

            // Tworzenie nowego klienta (domyślnie pokój "lobby")
            Client new_client{nick, sock, "lobby"};
            
            {
                lock_guard<mutex> lock(clients_mutex);
                clients.push_back(new_client);
            }

            cout << "[Polaczenie] " << nick << " dołączył do lobby.\n";

            // Start wątku obsługi
            thread(handle_client, new_client).detach();
        }
    } catch (exception& e) {
        cerr << "[Fatal Error] " << e.what() << endl;
    }

    return 0;
}