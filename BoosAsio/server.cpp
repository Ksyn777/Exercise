#include <boost/asio.hpp>
#include <iostream>

using boost::asio::ip::tcp;

int main() {
    boost::asio::io_context io;

    // 1. Tworzymy acceptor (nasłuchiwanie)
    tcp::acceptor acceptor(io, tcp::endpoint(tcp::v4(), 9000));

    std::cout << "Serwer nasluchuje na porcie 9000...\n";

    // 2. Akceptujemy połączenie od klienta
    tcp::socket socket(io);
    acceptor.accept(socket);

    std::cout << "Klient polaczony!\n";

    while (true) {
        try {
            char data[1024];

            // 3. Odbieramy dane
            size_t length = socket.read_some(boost::asio::buffer(data));

            std::cout << "Odebrano: ";
            std::cout.write(data, length);
            std::cout << std::endl;

            // 4. Odsyłamy to samo (echo)
            boost::asio::write(socket, boost::asio::buffer(data, length));
        }
        catch (std::exception& e) {
            std::cout << "Klient rozlaczony: " << e.what() << std::endl;
            break;
        }
    }

    return 0;
}
