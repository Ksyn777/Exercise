#include <iostream>
#include <boost/asio.hpp>
#include <string>

using namespace std;
using boost::asio::ip::tcp;

int main()
{
    boost::asio::io_context io;
    tcp::socket socket(io);
    //przygotowanie do tlumaczenia adresu i portu na endpoint
    tcp::resolver resolver(io);

    //Laczymy sie z serverem
    boost::asio::connect(socket, resolver.resolve("127.0.0.1", "9000"));
    cout<<"Klient polaczony z serwerem!"<<endl;
    while(true)
    {
        cout<<"Wpisz wiadomosc do wyslania (koniec aby zakonczyc): ";
        string message;
        getline(cin, message);
        if(message == "exit")
        {
            break;
        }
        //wysyla wiadomosc
        boost::asio::write(socket, boost::asio::buffer(message));
        char reply[1024];
        message+= "\n";
        size_t len = socket.read_some(boost::asio::buffer(reply));
        cout<<"Odpowiedz od serwera: ";
        cout.write(reply, len);
        cout<<endl;

    }
}