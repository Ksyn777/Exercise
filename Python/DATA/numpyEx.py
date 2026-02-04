import numpy as np
from numpy import random
print(np.__version__)

a = np.array([1, 2, 3])
print(a)
b = np.array([4, 5, 6])
print(b)

c = a + b
print(c)

print("Tablica od 0 do 9")
array_arange = np.arange(10)
print(array_arange)

print("Tablica z 10 równoodległymi wartościami od 0 do 1")
array_linspace = np.linspace(0, 1, 10)
print(array_linspace)

print("Same zera")
array_zero = np.zeros((3,3))
print(array_zero)

print("Losowe")
aray_random = np.random.random((3, 3))
print(aray_random)

print("Mnozenie")
mnozenie = np.dot(a, b)
print(c)

print("Generowanie danych dotyczących cen akcji") 
prices = np.random.randn(100)
print(prices)

print("Obliczanie zwrotów")
returns = np.diff(prices) / prices[:-1]
print(returns)

print("Średni zwrot")
average_return = np.mean(returns)
print(average_return)

print(f"Średni zwrot: {average_return:.2%}")

# inicjalizacja tablicy za pomocą pliku wejściowego
arr_file = np.loadtxt('file_name.txt')

# wyznaczenie rozwiązania układu równań liniowych Ax = b
A = np.array([[1, 2], [3, 4]])
b = np.array([5, 6])
x = np.linalg.solve(A, b)

# transpozycja macierzy a do macierzy b
b = np.transpose(a)

# tworzenie tablicy z 6 elementami
a = np.array([1, 2, 3, 4, 5, 6])
# obliczanie transformaty Fouriera
b = np.fft.fft(a)

# ustalenie ziarna dla generatora liczb losowych
np.random.seed(12345)
# wygenerowanie pięciu losowych wartości z rozkładu normalnego
a = np.random.randn(5)

#Ksztalt
arr = np.array([[1, 2, 3, 4], [5, 6, 7, 8]])
print(arr.shape)

#Zmaiana ksztaltu
arr = np.array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
newarr = arr.reshape(4, 3)
print(newarr)

#Splaszczenie
arr = np.array([[1, 2, 3], [4, 5, 6]])
newarr = arr.reshape(-1)

#Iteracja 
arr = np.array([[1, 2, 3], [4, 5, 6]])
for x in arr:
  print(x)

#Iteracja wierszami i kolumnami
arr = np.array([[1, 2, 3, 4], [5, 6, 7, 8]])
for x in np.nditer(arr[:, ::2]):
  print(x)

#Łączenie tablic
arr1 = np.array([1, 2, 3])
arr2 = np.array([4, 5, 6])
arr = np.concatenate((arr1, arr2))

#układanie w stos pionow
arr1 = np.array([1, 2, 3])
arr2 = np.array([4, 5, 6])
arr = np.stack((arr1, arr2), axis=1)

#Wzdluz kolumn 
arr = np.vstack((arr1, arr2))

#Dzielnie tablic 
newarr = np.array_split(arr, 3)  #[array([1, 2]), array([3, 4]), array([5, 6])]

#Za pomocą tej hsplit()metody podziel tablicę 2-D na trzy tablice 2-D wzdłuż kolumn
newarr = np.hsplit(arr, 3)

#wzraca indeksy szukanych elementów
x = np.where(arr == 4)
x = np.where(arr%2 == 0) #[0 1 2] zwraca indeksy parzystych elementów

#zwraca indeksy, w których należy wstawić element, aby zachować porządek posortowany
x = np.searchsorted(arr, 7)

#zwraca indeksy, w których należy wstawić element, aby zachować porządek posortowany (strona prawa)
x = np.searchsorted(arr, 7, side='right')

#Wiele wartosci 
x = np.searchsorted(arr, [2, 4, 6])

#filtrowanie
arr = np.array([41, 42, 43, 44])
# Create an empty list
filter_arr = []
for element in arr:
  # if the element is higher than 42, set the value to True, otherwise False:
  if element > 42:
    filter_arr.append(True)
  else:
    filter_arr.append(False)
newarr = arr[filter_arr]
print(filter_arr)
print(newarr)

#losowanie zmienoprzecinkowej
x = random.rand()

#losowanie calkowitej
x = random.randomint(100)

#rozmiar 5
x=random.randint(100, size=(5))

#2D 3 wiersze 
x = random.randint(100, size=(3, 5))

#wylosowanie z podanego zbioru
x = random.choice([3, 5, 7, 9])

#prawdopodobinstwo wylosowania, Suma wszystkich liczb prawdopodobieństwa powinna wynosić 1.
x = random.choice([3, 5, 7, 9], p=[0.1, 0.3, 0.6, 0.0], size=(100))

#Permutacja odnosi się do układu elementów. Np. [3, 2, 1] jest permutacją [1, 2, 3] i odwrotnie.
random.shuffle(arr)
#Metoda ta shuffle()wprowadza zmiany do oryginalnej tablicy.
#metoda tworzy nowa a orginalna pozostawia nie zmienionoa
(random.permutation(arr))
