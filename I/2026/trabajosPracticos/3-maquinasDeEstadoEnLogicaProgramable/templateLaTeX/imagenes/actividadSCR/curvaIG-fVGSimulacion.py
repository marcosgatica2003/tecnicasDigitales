import matplotlib.pyplot as plt
import numpy as np

voltajeCompuerta = np.array([0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0, 1.1, 1.2, 1.3, 1.4, 1.5])
corrienteCompuerta = np.array([5.85037e-13, 1.40575e-11, 6.26245e-10, 1.34543e-08, 5.34747e-08, 1.06154e-07, 1.97320e-07, 6.75251e-07, 2.78647e-06, 7.67763e-06, 1.46726e-05, 2.28192e-05, 3.16074e-05, 4.07886e-05])

plt.figure(figsize=(10, 6))
plt.plot(voltajeCompuerta, corrienteCompuerta * 1e6, 'b-', linewidth=2)
plt.xlabel('Voltaje de Compuerta $V_G$ (V)', fontsize=16)
plt.ylabel('Corriente de Compuerta $I_G$ (µA)', fontsize=16)
plt.title('Curva Característica de la Compuerta del SCR', fontsize=18)
plt.xticks(fontsize=14)
plt.yticks(fontsize=14)
plt.tight_layout()
plt.show()
