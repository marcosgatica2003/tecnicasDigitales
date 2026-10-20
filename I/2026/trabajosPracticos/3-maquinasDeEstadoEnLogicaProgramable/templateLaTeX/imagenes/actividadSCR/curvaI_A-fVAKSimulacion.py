import matplotlib.pyplot as plt
import numpy as np

voltajeAnodoCatodo = np.array([0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0, 1.1, 1.2, 1.3, 1.4, 1.5])
corrienteAnodo = np.array([-5.850375e-13, -1.405757e-11, -6.262451e-10, -1.345425e-08, -5.347218e-08, -1.061532e-07, -1.973201e-07, -6.752506e-07, -2.786436e-06, -7.677617e-06, -1.467268e-05, -2.281920e-05, -3.160738e-05, -4.078662e-05])

plt.figure(figsize=(10, 6))
plt.plot(voltajeAnodoCatodo, corrienteAnodo * 1e6, 'r-', linewidth=2)
plt.xlabel('Tensión Ánodo-Cátodo $V_{AK}$ (V)', fontsize=16)
plt.ylabel('Corriente de Ánodo $I_A$ (µA)', fontsize=16)
# plt.title('Curva Característica Ánodo-Cátodo del SCR', fontsize=18)
plt.xticks(fontsize=14)
plt.yticks(fontsize=14)
plt.tight_layout()
plt.show()
