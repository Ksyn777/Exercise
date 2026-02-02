#include <iostream>
#include <boost/asio.hpp>
#include <string>

using namespace std;
using boost::asio::ip::tcp;

int main()
{
    vector<tcp::socket> clients;
    boost::asio::io_context io;
    tcp::acceptor acceptor(io, tcp::endpoint(tcp::v4(), 9000));

    for(int i = 0; i < 2; ++i) {
        tcp::socket socket(io);
        acceptor.accept(socket);
        cout << "Klient " << i+1 << " polaczony!\n";
        clients.push_back(std::move(socket));
    }

    while(true) {
        for(size_t i = 0; i < clients.size(); ++i) {
            try {
                char data[1024];
                size_t length = clients[i].read_some(boost::asio::buffer(data));
                std::string message(data, length);

                cout << "Klient " << i+1 << ": " << message << endl;

                // Wyślij do pozostałych klientów
                for(size_t j = 0; j < clients.size(); ++j) {
                    if(j != i) {
                        boost::asio::write(clients[j], boost::asio::buffer(message));
                    }
                }
            } catch(std::exception& e) {
                cout << "Klient " << i+1 << " rozlaczony: " << e.what() << endl;
            }
        }
    }


    
    return 0;
    
}