import numpy as np
import matplotlib.pyplot as plt

voltajesAK = np.array([0, 0.3, 0.6, 0.9, 1.2, 1.5, 1.8])

corrientesG = [1.47e-3, 1.59e-3, 1.74e-3, 1.91e-3, 2.12e-3]

corrientesAK = np.array([
    [0, 190e-9, 380e-9, 2.80e-3, 2.8345e-3, 2.8347e-3, 2.8348e-3],
    [0, 190e-9, 371e-9, 2.11e-3, 2.1288e-3, 2.1290e-3, 2.1292e-3],
    [0, 190e-9, 371e-9, 2.1164e-3, 2.1288e-3, 2.1290e-3, 2.1292e-3],
    [0, 186e-9, 373e-9, 2.5361e-3, 2.5524e-3, 2.5526e-3, 2.5528e-3],
    [0, 186e-9, 373e-9, 2.8102e-3, 2.8345e-3, 2.8347e-3, 2.8349e-3]
])

plt.figure(figsize=(10, 6))

for i, iG in enumerate(corrientesG):
    plt.plot(voltajesAK, corrientesAK[i] * 1e3, 'o-', label=f'$I_G$ = {iG*1e3:.2f} mA', linewidth=2, markersize=6)

plt.xlabel('$V_{AK}$ [V]', fontsize=12)
plt.ylabel('$I_{AK}$ [mA]', fontsize=12)
plt.title('Curvas características $I_{AK}$ vs $V_{AK}$ para diferentes $I_G$', fontsize=13)
plt.grid(True, alpha=0.3)
plt.legend(fontsize=10)
plt.tight_layout()
plt.show()
