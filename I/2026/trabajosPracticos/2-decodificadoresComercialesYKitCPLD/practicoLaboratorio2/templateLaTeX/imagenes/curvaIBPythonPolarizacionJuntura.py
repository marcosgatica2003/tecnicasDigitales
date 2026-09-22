import matplotlib.pyplot as plt

vbe = [0.713, 0.717, 0.725, 0.731, 0.736, 0.760]
ib = [0.000, 0.028, 0.126, 0.226, 0.326, 0.924]

plt.figure(figsize=(8, 5))
plt.plot(vbe, ib, marker='o', linestyle='-', color='purple')
plt.xlabel('V_BE [V]')
plt.ylabel('I_B [mA]')
plt.title('Curva I_B = f(V_BE)')
plt.grid(True)
plt.savefig('curvaIBPythonPolarizacionJuntura.png', dpi=300)
plt.close()

