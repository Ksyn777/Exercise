#include <iostream>
#include <memory>
#include <string>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Podmiot;

class Display
{
    public:
    virtual ~Display() = default;
    virtual void showInfo() const = 0;
};

class Obserwator : public Display
{
    public:
    unique_ptr<Podmiot> obserwujacy;
    virtual ~Obserwator() = default;
    virtual void update(const unordered_map<string, double>& newKantor) = 0;
    virtual void showInfo() const override 
    {
        cout<<"Brak danych do wyswietlenia"<<endl;
    }
};

class Podmiot 
{
    public:
        virtual ~Podmiot() = default;
        virtual void addClient(Obserwator* obs) = 0;
        virtual void removeClient(Obserwator* obs) = 0;
        virtual void callToClients(vector<Obserwator*> listObservers) = 0;
};


class Exchange : public Podmiot
{
    private:
    unordered_map<string, double> kantor = {{"Euro", 0.00},
                                             {"Dolar", 0.00},
                                            {"Funt Brytyjski", 0.00},
                                            {"Dolar Austarlijski", 0.00}};
    public: 
    vector<Obserwator*> listObservers;
    void addClient(Obserwator* obs) override 
    {
        if(obs != nullptr)
        {
            listObservers.push_back(obs);
            cout<<"Dodano Klienta";
        }
        else
        {
            cout<<"Nie mozna dodac klienta!";
        }    
    }
    void removeClient(Obserwator* obs) override 
    {
        if(!listObservers.empty())
        {
            auto it = std::find(listObservers.begin(), listObservers.end(), obs);
            if(it != listObservers.end())
            {
                listObservers.erase(it);
                cout<<"Usunieto Klienta";
            }
            else
            {
                cout<<"Nie znaleziono klienta";
            }
        }
        else
        {
            cout<<"Lista jest pusta!";
        }
    }
    void callToClients(vector<Obserwator*> listObservers) override
    {
        for(auto& obs : listObservers)
        {
            obs->update(kantor);
        }
        cout<<"Powiadom obserwator";
    }
    void downPrize()
    {
        cout<<"Pobieram nowe dane";
    }
    void showInfo() const 
    {
        for(const auto& pair : kantor)
        {
            cout<<pair.first<<": "<<pair.second<<endl;
        }
    }
    void setKantor(const unordered_map<string, double>& newKantor)
    {
        unordered_map<string, double> kantor;
        this->kantor = newKantor;
    }

};


class BiznesClass : public Obserwator
{
    
    private:
    unordered_map<string, double> kantor = {{"Euro", 0.00},
                                             {"Dolar", 0.00},
                                            {"Funt Brytyjski", 0.00},
                                            {"Dolar Austarlijski", 0.00}};
    double znizka = 0.20;
    public:
    BiznesClass(unordered_map<string, double> ka, double z) : kantor(ka), znizka(z) {}
    unordered_map<string, double> operator- (const unordered_map<string, double>& other)
    {
        unordered_map<string, double> result = kantor;
        for(auto& pair : other)
        {
            result[pair.first] = pair.second - znizka;
        }
        return result;
    }
    void update(const unordered_map<string, double>& newKantor) override
    {
        this->kantor = *this - newKantor;
    }
    void showInfo() const override 
    {
        for(const auto waluta : kantor)
        {
            if(!kantor.empty())
            {
                cout<<waluta.first<<": "<<waluta.second<<endl;
            }
        }
    }


};

class PrivateClient : public Obserwator
{
    private:
    unordered_map<string, double> kantor = {{"Euro", 0.00},
                                             {"Dolar", 0.00},
                                            {"Funt Brytyjski", 0.00},
                                            {"Dolar Austarlijski", 0.00}};
    double znizka = 0.05;
    public:
    PrivateClient(unordered_map<string, double> ka, double z) : kantor(ka), znizka(z) {}
    unordered_map<string, double> operator- (const unordered_map<string, double>& other)
    {
        unordered_map<string, double> result;
        for(auto& pair : other)
        {
            result[pair.first] = pair.second - znizka;
        }
        return result;
    }
    void update(const unordered_map<string, double>& newKantor) override
    {
        this->kantor = *this - newKantor;
        cout<<"Kantor zaktualizowany dla klienta prywatnego"<<endl;
    }
    void showInfo() const override 
    {
        for(const auto waluta : kantor)
        {
            if(!kantor.empty())
            {
                cout<<waluta.first<<": "<<waluta.second<<endl;
            }
        }
    }
};

class GeneralClient : public Obserwator
{
    private:
    unordered_map<string, double> kantor = {{"Euro", 4.66},
                                             {"Dolar", 4.11},
                                            {"Funt Brytyjski", 5.23},
                                            {"Dolar Austarlijski", 3.77}};
    public:
    GeneralClient(unordered_map<string, double> ka) : kantor(ka) {}
    void update(const unordered_map<string, double>& newKantor) override
    {
        this->kantor = newKantor;
        cout<<"Aktualizacja kursow w kantorze dla klienta GeneralClient"<<endl;
    }
    void showInfo() const override 
    {
        for(const auto waluta : kantor)
        {
            if(!kantor.empty())
            {
                cout<<waluta.first<<": "<<waluta.second<<endl;
            }
        }
    }
};

/*int main()
{
    Exchange kantor;
    vector<Obserwator*> observers;
    BiznesClass BiznesObs({{"Euro", 4.66}, {"Dolar", 4.11}, {"Funt Brytyjski", 5.23}, {"Dolar Austarlijski", 3.77}}, 0.20);
    PrivateClient PrivateObs({{"Euro", 4.66}, {"Dolar", 4.11}, {"Funt Brytyjski", 5.23}, {"Dolar Austarlijski", 3.77}}, 0.05);
    GeneralClient GeneralObs({{"Euro", 4.66}, {"Dolar", 4.11}, {"Funt Brytyjski", 5.23}, {"Dolar Austarlijski", 3.77}});
    kantor.addClient(&BiznesObs);
    kantor.addClient(&PrivateObs);
    kantor.addClient(&GeneralObs);
    kantor.setKantor({{"Euro", 4.66}, {"Dolar", 4.11}, {"Funt Brytyjski", 5.23}, {"Dolar Austarlijski", 3.77}});
    kantor.callToClients(kantor.listObservers);
    BiznesObs.showInfo();
    PrivateObs.showInfo();
    GeneralObs.showInfo();


    return 0;
}
   */