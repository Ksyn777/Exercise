#include <iostream>
#include <boost/asio.hpp>
#include <string>
#include <thread>

using namespace std;
using boost::asio::ip::tcp;


int main()
{
    boost::asio::io_context io;
    tcp::socket socket(io);
    tcp::resolver resolver(io);
    auto endpoints = resolver.resolve("127.0.0.1", "9000");
    boost::asio::connect(socket, endpoints);
    cout<<"Klient polaczony z serwerem!"<<endl;
    while(true)
    {
        cout<<"Wpisz wiadomosc do wyslania (exit aby zakonczyc): ";
        string message;
        getline(cin, message);
        if(message == "exit")
        {
            break;
        }
        boost::asio::write(socket, boost::asio::buffer(message));
        char reply[1024];
        size_t len = socket.read_some(boost::asio::buffer(reply));
        cout<<"Odpowiedz od serwera: ";
        cout.write(reply, len);
        cout<<endl;
    }

    std::thread reader([&socket]() {
        try {
            char reply[1024];
            while(true) {
                size_t len = socket.read_some(boost::asio::buffer(reply));
                std::cout << "\nOd innych: ";
                std::cout.write(reply, len);
                std::cout << "\nWpisz wiadomosc: ";
            }
        } catch(std::exception& e) {
            std::cout << "Rozlaczono: " << e.what() << std::endl;
        }
    });
    reader.join(); // czekamy, aż wątek odbioru zakończy działanie
}