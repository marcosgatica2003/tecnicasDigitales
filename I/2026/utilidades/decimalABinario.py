def decimalABinario(n):
    cadenaDelBinario = bin(n)[2:]
    padding = (4 - len(cadenaDelBinario) % 4) % 4
    binarioConPadding = "0" * padding + cadenaDelBinario
    return " ".join(binarioConPadding[i:i+4] for i in range(0, len(binarioConPadding), 4))
print(decimalABinario(257734))

