#include <iostream>
#include <gtest/gtest.h>
#include <string>
#include <memory>
#include "Obserwator.cpp"
#include <gmock/gmock.h>

class ExchangeTest : public ::testing::Test
{
    public: 
    Exchange kantor;
    unique_ptr<BiznesClass> biznessObs;
    unique_ptr<PrivateClient> privateObs;
    unique_ptr<GeneralClient> generalObs;
    
    void SetUp() override
    {
        biznessObs = make_unique<BiznesClass>(unordered_map<string, double>{{"Euro", 4.66}, {"Dolar", 4.11}, {"Funt Brytyjski", 5.23}, {"Dolar Austarlijski", 3.77}}, 0.20);
        privateObs = make_unique<PrivateClient>(unordered_map<string, double>{{"Euro", 4.66}, {"Dolar", 4.11}, {"Funt Brytyjski", 5.23}, {"Dolar Austarlijski", 3.77}}, 0.05);
        generalObs = make_unique<GeneralClient>(unordered_map<string, double>{{"Euro", 4.66}, {"Dolar", 4.11}, {"Funt Brytyjski", 5.23}, {"Dolar Austarlijski", 3.77}});
    }

};

TEST_F(ExchangeTest, ExchangeShowInfo)
{
    testing::internal::CaptureStdout();
    kantor.showInfo();
    string output = testing::internal::GetCapturedStdout();
    EXPECT_TRUE(output.find("Euro: 0") != string::npos);
    EXPECT_TRUE(output.find("Dolar: 0") != string::npos);
    EXPECT_TRUE(output.find("Funt Brytyjski: 0") != string::npos);
    EXPECT_TRUE(output.find("Dolar Austarlijski: 0") != string::npos);
}

TEST_F(ExchangeTest, ExchangeDownPrize)
{
    testing::internal::CaptureStdout();
    kantor.downPrize();
    string output = testing::internal::GetCapturedStdout();
    EXPECT_TRUE(output.find("Pobieram nowe dane") != string::npos);
}

                            /////ADD CLIENT TESTS/////

TEST_F(ExchangeTest, AddClientBizness)
{
    testing::internal::CaptureStdout();
    kantor.addClient(biznessObs.get());
    string output = testing::internal::GetCapturedStdout();
    EXPECT_TRUE(output.find("Dodano Klienta") != string::npos);
}

TEST_F(ExchangeTest, AddClientBiznessFalse)
{
    testing::internal::CaptureStdout();
    kantor.addClient(nullptr);
    string output = testing::internal::GetCapturedStdout();
    EXPECT_TRUE(output.find("Nie mozna dodac klienta!") != string::npos);
}


TEST_F(ExchangeTest, AddClientPrivate)
{
    testing::internal::CaptureStdout();
    kantor.addClient(privateObs.get());
    string output = testing::internal::GetCapturedStdout();
    EXPECT_TRUE(output.find("Dodano Klienta") != string::npos);
}

TEST_F(ExchangeTest, AddClientPrivateFalse)
{
    testing::internal::CaptureStdout();
    kantor.addClient(nullptr);
    string output = testing::internal::GetCapturedStdout();
    EXPECT_TRUE(output.find("Nie mozna dodac klienta!") != string::npos);
}

TEST_F(ExchangeTest, AddClientGeneral)
{
    testing::internal::CaptureStdout();
    kantor.addClient(generalObs.get());
    string output = testing::internal::GetCapturedStdout();
    EXPECT_TRUE(output.find("Dodano Klienta") != string::npos);

}

TEST_F(ExchangeTest, AddClientGeneralFalse)
{
    testing::internal::CaptureStdout();
    kantor.addClient(nullptr);
    string output = testing::internal::GetCapturedStdout();
    EXPECT_TRUE(output.find("Nie mozna dodac klienta!") != string::npos);

}

                            /////REMOVE CLIENT TESTS/////

TEST_F(ExchangeTest, RemovevBiznessTest)
{
    kantor.addClient(biznessObs.get());
    testing::internal::CaptureStdout();
    kantor.removeClient(biznessObs.get());
    string output = testing::internal::GetCapturedStdout();
    EXPECT_TRUE(output.find("Usunieto Klienta") != string::npos);

}

TEST_F(ExchangeTest, RemovevBiznessTestFalse)
{
    kantor.addClient(biznessObs.get());
    testing::internal::CaptureStdout();
    kantor.removeClient(biznessObs.get());
    string output = testing::internal::GetCapturedStdout();
    EXPECT_TRUE(output.find("Nie znaleziono klienta") == string::npos);

}

TEST_F(ExchangeTest, RemovePrivateTest)
{
    kantor.addClient(privateObs.get());
    testing::internal::CaptureStdout();
    kantor.removeClient(privateObs.get());
    string output = testing::internal::GetCapturedStdout();
    EXPECT_TRUE(output.find("Usunieto Klienta") != string::npos);
}

TEST_F(ExchangeTest, RemovePrivateTestFalse)
{
    kantor.addClient(privateObs.get());
    testing::internal::CaptureStdout();
    kantor.removeClient(privateObs.get());
    string output = testing::internal::GetCapturedStdout();
    EXPECT_TRUE(output.find("Nie znaleziono klienta") == string::npos);
}

TEST_F(ExchangeTest, RemoveGeneralTest)
{
    kantor.addClient(generalObs.get());
    testing::internal::CaptureStdout();
    kantor.removeClient(generalObs.get());
    string output = testing::internal::GetCapturedStdout();
    EXPECT_TRUE(output.find("Usunieto Klienta") != string::npos);
}

TEST_F(ExchangeTest, RemoveGeneralTestFalse)
{
    kantor.addClient(generalObs.get());
    testing::internal::CaptureStdout();
    kantor.removeClient(generalObs.get());
    string output = testing::internal::GetCapturedStdout();
    EXPECT_TRUE(output.find("Nie znaleziono klienta") == string::npos);
}

class MockObserwator : public Obserwator {
public:
    MOCK_METHOD(void, update, ((const unordered_map<string, double>&)), (override));
    
    void showInfo() const override {} 
};

TEST_F(ExchangeTest, ShouldNotifyRegisteredClient) {
    Exchange localKantor; 
    MockObserwator mockClient;
    
    unordered_map<string, double> testoweKursy = {{"Euro", 4.50}};
    localKantor.setKantor(testoweKursy);
    localKantor.addClient(&mockClient);

    EXPECT_CALL(mockClient, update(testoweKursy)).Times(1);

    localKantor.callToClients(localKantor.listObservers);
}

TEST_F(ExchangeTest, ShouldApplyDiscountForBiznessClient) {
    unordered_map<string, double> noweKursy = {{"Euro", 4.66}};
    kantor.setKantor(noweKursy);
    biznessObs->update(noweKursy); 
    
    testing::internal::CaptureStdout();
    biznessObs->showInfo();
    string output = testing::internal::GetCapturedStdout();
    
    EXPECT_TRUE(output.find("Euro: 4.46") != string::npos);
}

TEST_F(ExchangeTest, ShouldApplyDiscountForPrivateClient)
{
    unordered_map<string, double> noweKursy = {{"Euro", 4.66}};
    kantor.setKantor(noweKursy);
    privateObs->update(noweKursy);

    testing::internal::CaptureStdout();
    privateObs->showInfo();
    string output = testing::internal::GetCapturedStdout();
    
    EXPECT_TRUE(output.find("Euro: 4.61") != string::npos);

}

TEST_F(ExchangeTest, ShouldApplyDiscountForGeneralClient)
{
    unordered_map<string, double> noweKursy = {{"Euro", 4.66}};
    kantor.setKantor(noweKursy);
    generalObs->update(noweKursy);

    testing::internal::CaptureStdout();
    generalObs->showInfo();
    string output = testing::internal::GetCapturedStdout();
    
    EXPECT_TRUE(output.find("Euro: 4.66") != string::npos);

}

TEST(ExchangeNotification, ShouldNotNotifyAfterRemoval) {
    Exchange kantor;
    MockObserwator mockClient;
    
    kantor.addClient(&mockClient);
    kantor.removeClient(&mockClient);

    EXPECT_CALL(mockClient, update(testing::_)).Times(0);

    kantor.callToClients(kantor.listObservers);
}

