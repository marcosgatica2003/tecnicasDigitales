for f in "Salidas y Entradas"*; do
    nuevoNombre="salidas${f#Salidas y Entradas}"
    mv "$f" "$nuevoNombre"
done
