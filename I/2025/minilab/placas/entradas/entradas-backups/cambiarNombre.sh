for f in "Salidas y Entradas"*; do
    nuevoNombre="entradas${f#Salidas y Entradas}"
    mv "$f" "$nuevoNombre"
done
