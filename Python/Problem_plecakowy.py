import random   
import pandas as pd

przedmioty = [(12, 2), (18, 5), (2, 16), (3, 14), (9, 3), (5, 14), (14, 12), (6, 6), (2, 5), (18, 12)]
przedmioty = pd.DataFrame(przedmioty, columns=['waga', 'wartosc'])
przedmioty.index.name = "przedmioty"

przedmioty.T

limitCalkowitejWagi = 71

genom = [random.randint(0, 5) == 0 for _ in range(len(przedmioty))]

def stworzPopulacje(wielkoscPopulacji: int):
    return [[random.randint(0, 5) == 0 for _ in range(len(przedmioty))] for _ in range(wielkoscPopulacji)]


def dopasowanie(geny: list):
    calkowitaWaga = 0
    calkowitaWartosc = 0
    for idx, gen in enumerate(geny):
        if gen:
            calkowitaWaga += przedmioty["waga"][idx]
            calkowitaWartosc += przedmioty["wartosc"][idx]

    if calkowitaWaga > limitCalkowitejWagi:
        return 0
    else:
        return calkowitaWartosc
    
def wybierzZwyciezcow(populacja: list):
    wartosciPopulacji = []
    for geny in populacja:
        wartosc = dopasowanie(geny=geny)
        if wartosc > 0:
            wartosciPopulacji.append((wartosc, geny))

    return [geny for wartosc, geny in sorted(wartosciPopulacji, key=lambda x: x[0], reverse=True)]

def wybierzNajlepszych(zyciezcy:list, populacja:list, procent=0.2):
    limit = int(procent * len(populacja))
    if len(zyciezcy) > limit:
        najlepsi = zyciezcy[:limit]
    else:
        najlepsi = zyciezcy
    return najlepsi

def krzyzuj(geny1: list, geny2: list):
    punktPrzeciecia = random.randint(1, len(geny1)-1)
    noweGeny = geny1[:punktPrzeciecia] + geny2[punktPrzeciecia:]
    return noweGeny

def mutuj(geny: list):
    noweGeny = list(geny)
    idx = random.randint(0, len(geny)-1)
    noweGeny[idx] = not bool(geny[idx])
    return noweGeny

def mutujLosowo(geny: list, prawdopodobienstwo:int=100):
    if random.randint(0, prawdopodobienstwo) == 0:
        return mutuj(geny)
    else:
        return list(geny)
    
def nastepnePokolenie(populacja: list):
    nowaPopulacja = []
    zwyciezcy = wybierzZwyciezcow(populacja)

    if len(zwyciezcy) > 0:
        zwyciezcy = wybierzNajlepszych(zwyciezcy, populacja, 0.2)
        for _ in range(len(populacja)):
            noweGeny = krzyzuj(random.choice(zwyciezcy), random.choice(zwyciezcy))
            nowaPopulacja.append(mutujLosowo(noweGeny))
    else:
        nowaPopulacja = stworzPopulacje(len(populacja))

    return nowaPopulacja

populacja = stworzPopulacje(1000)
for i in range(20):
    nowaPopulacja = nastepnePokolenie(populacja)
    populacja = nowaPopulacja

wyniki = pd.concat([pd.DataFrame(populacja).mean() * 100, przedmioty], axis=1)
wyniki.columns = ["wybieralnosc"] + list(przedmioty.columns)
wyniki.index.name = przedmioty.index.name
wyniki.T  

wyniki["wybieralnosc"].plot.bar()