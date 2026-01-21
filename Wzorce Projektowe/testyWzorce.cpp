#include <iostream>
#include <gtest/gtest.h>
#include <string>
#include <memory>
#include "Strategia.cpp"

class PayTest : public ::testing::Test
{
    public:
    unique_ptr<PaySystem> karta;
    unique_ptr<PaySystem> blik;
    unique_ptr<PaySystem> przelew;
    unique_ptr<PaySystem> raty;

    void SetUp() override
    {
        karta = make_unique<PaySystem>(move(make_unique<PayByCard>()), 1, "Platnosc karta");
        blik = make_unique<PaySystem>(move(make_unique<PayByBlik>()), 2, "Płatnosć blikiem");
        przelew = make_unique<PaySystem>(move(make_unique<PayByTransfer>()), 3, "Przelew");
        raty = make_unique<PaySystem>(move(make_unique<PayByInstallments>()), 4, "Płatnosc przelewem");
    }
};

TEST_F(PayTest, TestPlatnosciKarta)
{
    testing::internal::CaptureStdout();
    karta->payment();
    string output = testing::internal::GetCapturedStdout();
    EXPECT_TRUE(output.find("Platnosc numer: 1") != string::npos);
    EXPECT_TRUE(output.find("Zaplac karta!") != string::npos);
}

TEST_F(PayTest, TestPlatnoscBlikiem)
{
    testing::internal::CaptureStdout();
    blik->payment();
    string output = testing::internal::GetCapturedStdout();
    EXPECT_TRUE(output.find("Platnosc numer: 2") != string::npos);
    EXPECT_TRUE(output.find("Zaplac Blikiem!") != string::npos);
}

TEST_F(PayTest, TestPlatnoscPrzelewem)
{
    testing::internal::CaptureStdout();
    przelew->payment();
    string output = testing::internal::GetCapturedStdout();
    EXPECT_TRUE(output.find("Platnosc numer: 3") != string::npos);
    EXPECT_TRUE(output.find("Zaplac przelewem!") != string::npos);
}

TEST_F(PayTest, TestPlatnoscRaty)
{
    testing::internal::CaptureStdout();
    raty->payment();
    string output = testing::internal::GetCapturedStdout();
    EXPECT_TRUE(output.find("Platnosc numer: 4") != string::npos);
    EXPECT_TRUE(output.find("Zaplac w ratach") != string::npos);
}

struct PayTestData {
    unique_ptr<HowPay> paymentSystem;
    string expected_output;
};


class PaySystemParamTest : public testing::TestWithParam<pair<string, string>> {};

TEST_P(PaySystemParamTest, CorrectMessage)
{
    auto[strategyType, message] = GetParam();
    
    unique_ptr<HowPay> paymentSystem;
    if(strategyType == "Card") paymentSystem = make_unique<PayByCard>();
    else if(strategyType == "Blik") paymentSystem = make_unique<PayByBlik>();
    else if(strategyType == "Transfer") paymentSystem = make_unique<PayByTransfer>();
    else if(strategyType == "Installments") paymentSystem = make_unique<PayByInstallments>();

    PaySystem system(move(paymentSystem), 1, "Testowa");

    stringstream buffer;
    streambuf* old = cout.rdbuf(buffer.rdbuf()); //pobierasz adres bufora Twojej zmienne  i ustawiasz ten bufor jako cel dla std::cout

    system.payment();

    cout.rdbuf(old); //stan pierwotny
    string output = buffer.str();

    cout << "DEBUG: Przechwycony tekst to: [" << output << "]" << std::endl;

    EXPECT_NE(output.find(message), string::npos);


}

INSTANTIATE_TEST_SUITE_P(
    PaymentMethods,
    PaySystemParamTest,
    ::testing::Values(
        make_pair("Card", "Zaplac karta!"),
        make_pair("Blik", "Zaplac Blikiem!"),
        make_pair("Transfer", "Zaplac przelewem!"),
        make_pair("Installments", "Zaplac w ratach")
    )
);

TEST(PaySystemTest, ChangePaymentMethod)
{
    unique_ptr<HowPay> initialPayment = make_unique<PayByCard>();
    PaySystem system(move(initialPayment), 1, "Testowa");

    stringstream buffer;
    streambuf* old = cout.rdbuf(buffer.rdbuf());

    system.payment();
    string output1 = buffer.str();
    buffer.str(""); 

    unique_ptr<HowPay> newPayment = make_unique<PayByBlik>();
    system.setPayment(move(newPayment));
    system.payment();
    string output2 = buffer.str();

    cout.rdbuf(old); // Restore original buffer

    EXPECT_NE(output1.find("Zaplac karta!"), string::npos);
    EXPECT_NE(output2.find("Zaplac Blikiem!"), string::npos);
}