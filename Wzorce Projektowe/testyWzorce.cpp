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



