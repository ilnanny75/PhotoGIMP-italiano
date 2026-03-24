     1	#!/bin/bash
     2	
     3	echo "--- Inizio installazione PhotoGIMP in Italiano ---"
     4	
     5	# Imposta Geany come editor di testo predefinito per la sessione
     6	export EDITOR=geany
     7	echo "Geany impostato come editor predefinito per questa sincronizzazione."
     8	
     9	# Percorso di GIMP (Flatpak è lo standard per PhotoGIMP)
    10	TARGET="$HOME/.var/app/org.gimp.GIMP/config/GIMP/2.10"
    11	
    12	if [ -d "$TARGET" ]; then
    13	    echo "Cartella GIMP trovata. Copia dei file in corso..."
    14	    cp -rv .icons .local .var "$HOME/"
    15	    echo "Sincronizzazione completata con successo!"
    16	else
    17	    echo "ERRORE: Cartella di configurazione di GIMP non trovata."
    18	    echo "Assicurati di aver installato GIMP tramite Flatpak."
    19	fi
    20	
    21	echo "--- Installazione Terminata ---"
