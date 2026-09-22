import matplotlib.pyplot as plt
import numpy as np

vDs = [1, 2.061, 3, 3.042, 4.01, 5, 6, 7, 8.02, 10.02, 11, 12, 13, 14.02, 15]
iDs = [0.68, 4.88, 5.92, 6.54, 7.63, 8.05, 8.86, 9.18, 9.57, 10.24]

vDsFiltered = vDs[:len(iDs)]

plt.figure(figsize=(10, 8))
plt.plot(vDsFiltered, iDs, 'bo-', linewidth=2, markersize=6, label='I_DS vs V_DS')

plt.xlabel('V_DS [V]', fontsize=14)
plt.ylabel('I_DS [mA]', fontsize=14)
plt.title('I_DS = f(V_DS)', fontsize=14)
plt.grid(True, alpha=0.3)
plt.legend()

plt.xlim(0, max(vDsFiltered) + 1)
plt.ylim(0, max(iDs) + 1)

plt.tight_layout()
plt.show()
