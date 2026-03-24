#!/bin/bash

echo "--- Controllo Sistema per PhotoGIMP Italiano ---"

# 1. Impostazione Geany come predefinito (come richiesto)
if command -v geany >/dev/null 2>&1; then
    xdg-mime default geany.desktop text/plain
    echo "[OK] Geany impostato come editor predefinito."
else
    echo "[!] Geany non trovato, salto impostazione editor."
fi

# 2. Ricerca automatica della cartella di GIMP
# Cerchiamo qualsiasi cartella di versione (2.10, 3.0, ecc.) dentro .config/GIMP o .var
GIMP_BASE_DIR=""
for dir in "$HOME/.config/GIMP" "$HOME/.var/app/org.gimp.GIMP/config/GIMP"; do
    if [ -d "$dir" ]; then
        GIMP_BASE_DIR="$dir"
        break
    fi
done

if [ -z "$GIMP_BASE_DIR" ]; then
    echo "ERRORE: Non trovo nessuna installazione di GIMP."
    echo "Apri GIMP almeno una volta prima di installare la patch."
    exit 1
fi

# Trova la sottocartella della versione (es. 2.10 o 3.0)
VERSION_DIR=$(ls -d "$GIMP_BASE_DIR"/[0-9].* 2>/dev/null | head -n 1)

if [ -z "$VERSION_DIR" ]; then
    echo "ERRORE: Cartella GIMP trovata ma nessuna versione (es. 2.10) rilevata."
    exit 1
fi

echo "[OK] Destinazione rilevata: $VERSION_DIR"

# 3. Verifica che i file della patch esistano nel repository
if [ ! -d ".config/GIMP" ]; then
    echo "ERRORE: I file della patch non sono presenti nella cartella corrente."
    echo "Assicurati di lanciare lo script dall'interno del repository."
    exit 1
fi

# 4. Installazione (Sincronizzazione)
echo "Sincronizzazione file in corso..."

# Copia icone e lanciatori di sistema
cp -rv .local "$HOME/"

# Copia la configurazione specifica (usiamo la cartella del repo .config/GIMP/3.0 come sorgente base)
# ma la adattiamo alla versione trovata sul sistema
SOURCE_DIR=$(ls -d .config/GIMP/[0-9].* 2>/dev/null | head -n 1)
cp -rv "$SOURCE_DIR"/* "$VERSION_DIR/"

echo "------------------------------------------"
echo "INSTALLAZIONE COMPLETATA CON SUCCESSO!"
echo "Versione patchata: $(basename "$VERSION_DIR")"
echo "Ora puoi aprire GIMP."
