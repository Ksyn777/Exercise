#include <iostream>
#include <memory>
#include <string>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Message 
{
    public:
    virtual ~Message() = default;
    virtual void sendMessage() = 0;
};

class EmailMessage : public Message
{
    protected: 
    string reciper;
    string message;
    public:
    EmailMessage(string r, string m) : reciper(r), message(m) {}
    void sendMessage()  override 
    {
        cout<<"You are send email to: "<<reciper;
    }
    void getReciper()
    {
        cout<<reciper;
    }
    void getMessage()
    {
        cout<<message;
    }
};

class MessageDecorator : public Message
{
    protected:
    Message* mess;
    public:
    MessageDecorator(Message* msg) : mess(msg) {}
    void sendMessage() override
    {
        if(mess != nullptr)
        {
            mess->sendMessage();
        }
        cout<<"You are send email to: ";
    }
    virtual ~MessageDecorator() {
        delete mess; 
    }
};

class SendSlack : public  MessageDecorator
{
    public:
    SendSlack(Message* msg) : MessageDecorator(msg) {}
    void sendMessage() override
    {
        MessageDecorator::sendMessage();
        cout<<"Send message to Slack";
    }
    
};

class SendSms : public MessageDecorator 
{
    public: 
    SendSms(Message* msg) : MessageDecorator(msg) {}
    void sendMessage() override
    {
        MessageDecorator::sendMessage();
        cout<<"Send message to phone";
    }

};
class LogDecorator : public MessageDecorator
{
    public:
    LogDecorator(Message* msg) : MessageDecorator(msg) {}
    void sendMessage() override
    {
        MessageDecorator::sendMessage();
        cout<<"Send message to Log";
    }
};