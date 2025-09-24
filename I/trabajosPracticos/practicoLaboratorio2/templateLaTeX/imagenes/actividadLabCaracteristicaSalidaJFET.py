import matplotlib.pyplot as plt
import numpy as np

vDs = [0, 0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

iDs0V = [0, 0.5, 1.09, 2.13, 3.15, 3.95, 4.50, 4.9, 5.20, 5.44, 5.60, 5.93]
iDsNeg02V = [0, 0.52, 0.95, 1.40, 1.67, 1.9, 2.10, 2.26, 2.44, 2.6, 2.73, 3.08]
iDsNeg04V = [0, 0.07, 0.11, 0.17, 0.23, 0.29, 0.36, 0.4, 0.50, 0.55, 0.62, 0.7]
iDsNeg05V = [0, 0.01, 0.02, 0.05, 0.07, 0.09, 0.12, 0.15, 0.18, 0.22, 0.26, 0.3]

plt.figure(figsize=(12, 8))

plt.plot(vDs, iDs0V, 'b-o', linewidth=2, markersize=4, label='V_GS = 0V')
plt.plot(vDs, iDsNeg02V, 'r-s', linewidth=2, markersize=4, label='V_GS = -0.2V')
plt.plot(vDs, iDsNeg04V, 'g-^', linewidth=2, markersize=4, label='V_GS = -0.4V')
plt.plot(vDs, iDsNeg05V, 'm-d', linewidth=2, markersize=4, label='V_GS = -0.5V')

plt.xlabel('V_DS [V]', fontsize=14)
plt.ylabel('I_DS [mA]', fontsize=14)
plt.title('Características del JFET: I_DS vs V_DS', fontsize=14)
plt.grid(True, alpha=0.3)
plt.legend(fontsize=14)
plt.tick_params(axis='both', which='major', labelsize=14)

plt.xlim(0, 10.5)
plt.ylim(0, 6.5)

plt.tight_layout()
plt.show()
