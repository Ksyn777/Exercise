#include <iostream>
#include <memory>
#include <string>

using namespace std;

//Klasa Abstakcyjna

class HowPay
{
    public:
        virtual ~HowPay() = default;
        virtual void pay() = 0;
};

class PayByCard : public HowPay
{
    public:
    void pay() override
    {
        cout<<"Zaplac karta!";
    }
};

class PayByBlik : public HowPay
{
    public:
    void pay() override
    {
        cout<<"Zaplac Blikiem!";
    }

};

class PayByTransfer : public HowPay
{
    public:
    void pay() override
    {
        cout<<"Zaplac przelewem!";
    }
};

class PayByInstallments : public HowPay
{
    public:
    void pay()
    {
        cout<<"Zaplac w ratach";
    }
};

class PaySystem {
    protected:
        unique_ptr<HowPay> howpay;
        int id; 
        string name;
    public:
        PaySystem(unique_ptr<HowPay> hp, int i, string n) : howpay(std::move(hp)), id(i), name(n) {}
        void payment()
        {
            cout<<"Platnosc numer: "<<id<<" o nazwie: "<<name;
            if(howpay)
            {
                howpay->pay();
            }
        }
        void setPayment(unique_ptr<HowPay> hp)
        {
            howpay = move(hp);
        }
        
};
