import matplotlib.pyplot as plt
import numpy as np
from scipy.stats import linregress

ib = np.array([5, 7, 10, 20])
ic2V = np.array([2.25, 2.90, 4.44, 8.52])
ic5V = np.array([2.317, 3.01, 4.598, 8.813])
ic8V = np.array([2.39, 3.258, 4.75, 9.096])

plt.figure(figsize=(10, 6))

plt.plot(ib, ic2V, 'ro-', label='VCE = 2V', linewidth=2, markersize=8)
plt.plot(ib, ic5V, 'go-', label='VCE = 5V', linewidth=2, markersize=8)
plt.plot(ib, ic8V, 'bo-', label='VCE = 8V', linewidth=2, markersize=8)

slope2V, intercept2V, r2V, p2V, stderr2V = linregress(ib, ic2V)
slope5V, intercept5V, r5V, p5V, stderr5V = linregress(ib, ic5V)
slope8V, intercept8V, r8V, p8V, stderr8V = linregress(ib, ic8V)

ibFit = np.linspace(min(ib), max(ib), 100)
icFit2V = slope2V * ibFit + intercept2V
icFit5V = slope5V * ibFit + intercept5V
icFit8V = slope8V * ibFit + intercept8V

plt.plot(ibFit, icFit2V, 'r--', alpha=0.7)
plt.plot(ibFit, icFit5V, 'g--', alpha=0.7)
plt.plot(ibFit, icFit8V, 'b--', alpha=0.7)

beta2V = slope2V * 1000
beta5V = slope5V * 1000
beta8V = slope8V * 1000

plt.xlabel('IB [μA]', fontsize=12)
plt.ylabel('IC [mA]', fontsize=12)
plt.title('IC vs IB', fontsize=14)
plt.grid(True, alpha=0.3)
plt.legend()

plt.text(0.02, 0.98, f'β (VCE=2V) = {beta2V:.1f}', transform=plt.gca().transAxes, 
         verticalalignment='top', bbox=dict(boxstyle='round', facecolor='red', alpha=0.3))
plt.text(0.02, 0.90, f'β (VCE=5V) = {beta5V:.1f}', transform=plt.gca().transAxes, 
         verticalalignment='top', bbox=dict(boxstyle='round', facecolor='green', alpha=0.3))
plt.text(0.02, 0.82, f'β (VCE=8V) = {beta8V:.1f}', transform=plt.gca().transAxes, 
         verticalalignment='top', bbox=dict(boxstyle='round', facecolor='blue', alpha=0.3))

plt.tight_layout()
plt.savefig('betaCurvaPython.png', dpi=300, bbox_inches='tight')
plt.close()
