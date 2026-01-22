#include <iostream>
#include <gtest/gtest.h>
#include <string>
#include <memory>
#include "Dekorator.cpp"
#include <gmock/gmock.h>

class DecoratorTest : public ::testing::Test
{
    public:
    unique_ptr<Message> finalMessage;
    void SetUp() override
    {
        Message* email = new EmailMessage("admin@test.pl", "Błąd systemu");
        Message* slack = new SendSlack(email);
        Message* sms = new SendSms(slack);
        finalMessage = make_unique<LogDecorator>(sms);
    }

        

};

TEST_F(DecoratorTest, FullChainCheck) {
    testing::internal::CaptureStdout();
    
    finalMessage->sendMessage();
    
    string output = testing::internal::GetCapturedStdout();

    EXPECT_TRUE(output.find("You are send email to: admin@test.pl") != string::npos);
    EXPECT_TRUE(output.find("Send message to Slack") != string::npos);
    EXPECT_TRUE(output.find("Send message to phone") != string::npos);
    EXPECT_TRUE(output.find("Send message to Log") != string::npos);
}

TEST_F(DecoratorTest, EmailMessageCheck) {
    auto emailOnly = make_unique<EmailMessage>("user@test.pl", "Hello");
    testing::internal::CaptureStdout();
    emailOnly->sendMessage();
    string output = testing::internal::GetCapturedStdout();
    EXPECT_TRUE(output.find("You are send email to: user@test.pl") != string::npos);
    EXPECT_FALSE(output.find("Send message to Slack") != string::npos);
}

TEST_F(DecoratorTest, SlackEmailCheck)
{
    Message* email = new EmailMessage("user@test.pl", "Hello Slack");
    auto slackEmail = make_unique<SendSlack>(email);

    testing::internal::CaptureStdout();
    slackEmail->sendMessage();

    string output = testing::internal::GetCapturedStdout();
    EXPECT_TRUE(output.find("You are send email to: user@test.pl") != string::npos);
    EXPECT_TRUE(output.find("Send message to Slack") != string::npos);
    EXPECT_FALSE(output.find("Send message to phone") != string::npos);

}

TEST_F(DecoratorTest, SlackSmsEmailCheck)
{
    Message* msg = new EmailMessage("user@test.pl", "Hello");
    msg = new SendSms(msg);
    auto slackEmailSms = make_unique<SendSlack>(msg);
    testing::internal::CaptureStdout();
    slackEmailSms->sendMessage();
    string output = testing::internal::GetCapturedStdout();
    EXPECT_TRUE(output.find("You are send email to: user@test.pl") != string::npos);
    EXPECT_TRUE(output.find("Send message to Slack") != string::npos);
    EXPECT_TRUE(output.find("Send message to phone") != string::npos);
    EXPECT_FALSE(output.find("Send message to Log") != string::npos);

}

