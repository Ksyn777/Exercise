import pandas as pd
import numpy as np
import pylab

klasa = ["Pierwsza", "Pierwsza", "Druga", "Pierwsza", "Pierwsza", "Druga",
         "Pierwsza", "Pierwsza", "Druga", "Pierwsza", "Pierwsza", "Druga",
         "Pierwsza", "Pierwsza", "Druga", "Pierwsza", "Pierwsza", "Druga", 
         "Pierwsza", "Pierwsza"]

sex = ["Male", "Male", "female", "Male", "Male", "female", 
       "Male", "Male", "female", "Male", "Male", "female",
       "Male", "Male", "female", "Male", "Male", "female",
       "Male", "Male"]

# Powyżej 30 = 0, Poniżej 30 = 1
age = ["1", "0", "1", "0", "0", "1", "1", "0", "1", "0", "0", "1",
       "0", "0", "0", "0", "1", "0", "1", "1"]

# 1 = Tak, 0 = Nie
married = ["0", "0", "0", "0", "0", "1", "1", "0", "1", "0", "0", "1",
           "0", "1", "1", "0", "1", "0", "1", "0"]

survivor = ["0", "0", "0", "0", "1", "0", "1","0", "1", "1", "0",
            "0", "1", "1", "0", "0", "0", "0", "1", "1"]

# Tworzymy DataFrame
titanic = pd.DataFrame({"Klasa": klasa, "Sex": sex, "Age": age, "Married": married, "survivor": survivor}) 
print(titanic)

# Tworzymy wykres w NumPy
# Generujemy x i y do wykresu
x = np.linspace(0.0001, 0.9999, 1000)
# Wyznaczanie wartości entropii 
y = -x * np.log2(x) - (1-x) * np.log2(1-x)

pylab.plot(x, y)
pylab.grid()
pylab.show()

# Zmienna obliczająca entropię żywych do martwych
H_surv = len(titanic[titanic["survivor"] == "1"]) / len(titanic)
H_non_surv = len(titanic[titanic["survivor"] == "0"]) / len(titanic)

print(H_surv)
print(H_non_surv)

H_survivor = -H_surv * np.log2(H_surv) - H_non_surv * np.log2(H_non_surv)
print("Liczba żywych: ", H_survivor)

# Podział według płci
Kl_male = len(titanic[titanic["Sex"] == "Male"])
Kl_female = len(titanic[titanic["Sex"] == "female"])

print(f'Liczba mężczyzn: {Kl_male}')
print(f'Liczba kobiet: {Kl_female}')
