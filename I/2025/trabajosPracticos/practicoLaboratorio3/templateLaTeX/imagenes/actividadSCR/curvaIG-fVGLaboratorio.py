import matplotlib.pyplot as plt
import numpy as np

vG = np.array([0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8])
iG = np.array([634e-6, 936e-6, 1266e-6, 1588e-6, 233e-3, 281e-3, 313e-3])

plt.figure(figsize=(10, 6))
plt.plot(vG, iG * 1e3, 'bo-', linewidth=2, markersize=8)
plt.xlabel('$V_G$ [V]', fontsize=12)
plt.ylabel('$I_G$ [mA]', fontsize=12)
plt.title('$I_G$ vs $V_G$', fontsize=14)
plt.tight_layout()
plt.show()
