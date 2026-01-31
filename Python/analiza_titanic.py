import pandas as pd 
import numpy as np

data_titanic = pd.read_excel('C:\\Users\\Lenovo-X260\\Desktop\\Studia\\AI\\Titanic\\titanic_python.xlsx')
exel = pd.DataFrame(data_titanic)



#Ilość ludzi ocalonych
people = len(data_titanic)
survive = len(data_titanic[data_titanic["Survived"] == 1]) 
non_survive = len(data_titanic[data_titanic["Survived"] == 0])

male = len(data_titanic[data_titanic["Sex"] == 0]) 
female = len(data_titanic[data_titanic["Sex"] == 1]) 

adult = len(data_titanic[data_titanic["Age"] > 15]) 
children = len(data_titanic[data_titanic["Age"] <= 15]) 

class_1 = len(data_titanic[data_titanic["Pclass"] == 1]) 
class_2 = len(data_titanic[data_titanic["Pclass"] == 2]) 
class_3 = len(data_titanic[data_titanic["Pclass"] == 3]) 



#Funkcja do obliczania proporcji
def oblicz_proporcje(df,kolumna, wartosc):
    return len(df[df[kolumna] == wartosc]) / len(df)


def ile_ocalalych_wiek(df, kolumna, warunek, kolumna_2, wartosc_2):
    return len(df[(df[kolumna].apply(warunek)) & (df[kolumna_2] == wartosc_2)])


def ile_ocalalych(df, kolumna, wartosc, kolumna_2, wartosc_2):
    return len(df[(df[kolumna] == wartosc) & (df[kolumna_2] == wartosc_2)]) 

#Ilu mężczyzn ocalało
Io_male = ile_ocalalych(data_titanic, "Sex", 0, "Survived", 1 )
I_nie_o_male = ile_ocalalych(data_titanic, "Sex", 0, "Survived", 0 )

#Ile Kobiet ocalało
Io_female = ile_ocalalych(data_titanic, "Sex", 1, "Survived", 1 )
I_nie_o_female = ile_ocalalych(data_titanic, "Sex", 1, "Survived", 0 )

#Ile dorosłych ocalało
Io_adult = ile_ocalalych_wiek(data_titanic, "Age", lambda x: x > 15, "Survived", 1)
I_nie_o_adult = ile_ocalalych_wiek(data_titanic, "Age", lambda x: x > 15, "Survived", 0)

#Ile dzieci ocalało
Io_children = ile_ocalalych_wiek(data_titanic, "Age", lambda x: x <= 15, "Survived", 1)
I_nie_o_children = ile_ocalalych_wiek(data_titanic, "Age", lambda x: x <= 15, "Survived", 0)

Io_class1 = ile_ocalalych(data_titanic, "Pclass", 1, "Survived", 1 )
I_nie_o_class1 = ile_ocalalych(data_titanic, "Pclass", 1, "Survived", 0 )

Io_class2 = ile_ocalalych(data_titanic, "Pclass", 2, "Survived", 1 )
I_nie_o_class2 = ile_ocalalych(data_titanic, "Pclass", 2, "Survived", 0 )

Io_class3 = ile_ocalalych(data_titanic, "Pclass", 3, "Survived", 1 )
I_nie_o_class3 = ile_ocalalych(data_titanic, "Pclass", 3, "Survived", 0 )


def oblicz_wartosci(x, y):
    result = x / y
    return result

H_male_x = oblicz_wartosci(Io_male, male)
H_male_y = oblicz_wartosci(I_nie_o_male, male)

H_female_x= oblicz_wartosci(Io_female, female)
H_female_y= oblicz_wartosci(I_nie_o_female, female)

H_adult_x = oblicz_wartosci(Io_adult, adult)
H_adult_y = oblicz_wartosci(I_nie_o_adult, adult)
                            
H_children_x = oblicz_wartosci(Io_children, children)     
H_children_y = oblicz_wartosci(I_nie_o_children, children) 

H_class_1_x = oblicz_wartosci(Io_class1, class_1)
H_class_1_y = oblicz_wartosci(I_nie_o_class1, class_1)

H_class_2_x = oblicz_wartosci(Io_class2, class_2)
H_class_2_y = oblicz_wartosci(I_nie_o_class2, class_2)

H_class_3_x = oblicz_wartosci(Io_class3, class_3)
H_class_3_y = oblicz_wartosci(I_nie_o_class3, class_3)


#ENTROPIA 
def entriopia(x, y):
    wynik = -x * np.log2(x) - y * np.log2(y)
    return wynik

E_male = entriopia(H_male_x, H_male_y)

E_female = entriopia(H_female_x, H_female_y)

E_adult = entriopia(H_adult_x, H_adult_y)

E_children = entriopia(H_children_x, H_children_y)

E_class1 = entriopia(H_class_1_x, H_class_1_y)

E_class2 = entriopia(H_class_2_x, H_class_2_y)

E_class3 = entriopia(H_class_3_x, H_class_3_y)

data = {
    'Kategorie': ['Mężczyźni', 'Kobiety', 'Dorośli', 'Dzieci', 'Klasa 1', 'Klasa 2', 'Klasa 3'],
    'Ocaleni': [Io_male, Io_female, Io_adult, Io_children, Io_class1, Io_class2, Io_class3],
    'Nieocaleni': [I_nie_o_male, I_nie_o_female, I_nie_o_adult, I_nie_o_children, I_nie_o_class1, I_nie_o_class2, I_nie_o_class3],
    'Proporcja ocalonych': [H_male_x, H_female_x, H_adult_x, H_children_x, H_class_1_x, H_class_2_x, H_class_3_x],
    'Proporcja nieocalonych': [H_male_y, H_female_y, H_adult_y, H_children_y, H_class_1_y, H_class_2_y, H_class_3_y],
    'Entropia': [E_male, E_female, E_adult, E_children, E_class1, E_class2, E_class3]
}

# Tworzymy DataFrame
df_result = pd.DataFrame(data)

print(df_result)

minimalna_entropia = df_result['Entropia'].min()
print(f"\nNajmnijesza Entropia wystepuje u Mężczyzn: {minimalna_entropia}, jednakże wskazuje ona na największą umieralność wśród tej grupy")

for i in range(len(df_result)):  
    if df_result.loc[i, "Proporcja ocalonych"] > df_result.loc[i, "Proporcja nieocalonych"]:  
        print(f"Najwięcej ocalałych jest w kategorii: {df_result.loc[i, 'Kategorie']} z entropią: {df_result.loc[i, 'Entropia']}")

