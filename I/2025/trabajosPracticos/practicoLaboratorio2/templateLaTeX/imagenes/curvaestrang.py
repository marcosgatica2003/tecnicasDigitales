import matplotlib.pyplot as plt

# Ejemplo de listas de valores
vGs = [100, 220, 350, 400, 500, 600, 700]
iDs = [4.48, 2.59, 1.55, 0.60, 0.30, 0.07, 0]

vGsFiltered = vGs[:len(iDs)]

plt.figure(figsize=(10, 8))
plt.plot(vGsFiltered, iDs, 'bo-', linewidth=2, markersize=6, label='I_DS vs V_GS')

plt.xlabel('V_GS [V]', fontsize=14)
plt.ylabel('I_DS [mA]', fontsize=14)
plt.title('I_DS = f(V_GS)', fontsize=14)
plt.grid(True, alpha=0.3)
plt.legend()
plt.tick_params(axis='both', which='major', labelsize=12)

plt.xlim(0, max(vGsFiltered) + 1)
plt.ylim(0, max(iDs) + 1)
plt.legend(fontsize=14)
plt.tight_layout()
plt.show()
