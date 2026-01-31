import pylab
import numpy as np
import pandas as pd

wolne = ['książka', 'książka', 'książka', 'książka', 'telewizja', 'książka', 'telewizja', 'telewizja', 'książka', 
         'książka', 'telewizja', 'telewizja', 'telewizja', 'książka', 'telewizja', 'telewizja', 'telewizja', 'książka', 
         'książka', 'telewizja']
napój = ['herbata', 'kawa', 'kawa', 'herbata', 'kawa', 'kawa', 'herbata', 'kawa', 'kawa', 'herbata', 'herbata', 
         'herbata', 'kawa', 'kawa', 'herbata', 'kawa', 'herbata', 'herbata', 'herbata', 'kawa']
wyjście = ['teatr', 'teatr', 'kino', 'kino', 'teatr', 'kino', 'kino', 'teatr', 'kino', 'kino', 'kino', 'teatr', 'teatr',
           'teatr', 'kino', 'kino', 'teatr', 'teatr', 'teatr', 'teatr']
po_roku = ['Tak', 'Nie', 'Tak', 'Tak', 'Nie', 'Tak', 'Nie', 'Tak', 'Nie', 'Tak', 'Nie', 'Nie', 'Nie', 'Tak', 'Nie', 
           'Nie', 'Tak', 'Nie', 'Nie', 'Tak']

prenumeratorzy = pd.DataFrame({"wolne": wolne, "napój": napój, "wyjście": wyjście, "po_roku":po_roku}) #Tworzy macierz
prenumeratorzy


x = np.linspace(0.0001,0.9999,1000) # 1000 punktów generuje liczbe między tymi wartościami

y = -x * np.log2(x) - (1-x) * np.log2(1-x) # wyznaczenie wartości entropii

# wykres
pylab.plot(x,y)
pylab.grid()
pylab.show()

#Zmienna Zlicza liczbe Tak w kolumnie po_roku i dzieli przez sume Tak i Nie
P_Tak = len(prenumeratorzy[prenumeratorzy["po_roku"] == "Tak"]) / len(prenumeratorzy) 
P_Nie = len(prenumeratorzy[prenumeratorzy["po_roku"] == "Nie"]) / len(prenumeratorzy)

print("Tak = " , P_Tak, "Nie = ", P_Nie)
 
#Zmienna obliczająca entropie Tak do Nie w całości
H_całość = -P_Tak * np.log2(P_Tak) - P_Nie * np.log2(P_Nie)

print("H_ całość = ", H_całość)

#PODZIAŁ PO CZASIE WOLNYM

prenumeratorzy_książka = prenumeratorzy[prenumeratorzy["wolne"] == "książka"]
prenumeratorzy_telewizja = prenumeratorzy[prenumeratorzy["wolne"] == "telewizja"]

print("Książka: ", prenumeratorzy_książka)
print(" ")

