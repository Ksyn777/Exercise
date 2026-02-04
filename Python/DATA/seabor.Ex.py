import matplotlib.pyplot as plt
import seaborn as sns
from numpy import random

sns.displot([0, 1, 10, 11], kind="kde")

plt.show()

#loc- (Średnia) gdzie znajduje się szczyt dzwonu.
#scale- (Odchylenie standardowe) jak płaski powinien być rozkład na wykresie.
#size- Kształt zwróconej tablicy.

x = random.normal(loc=1, scale=2, size=(2, 3))