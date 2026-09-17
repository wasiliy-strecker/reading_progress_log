# Projektstände im PDF chronologisch nummerieren

Verlaufs-PDFs zeigen den neuesten Projektstand weiterhin zuerst. Die Nummerierung
beginnt jetzt beim ältesten Stand mit 1, sodass drei Einträge als 3, 2, 1 erscheinen.
Übersicht, Detailüberschriften und weitere Fotozeilen verwenden dieselbe Nummer.
Kompakte Einträge ohne Detailabschnitt zählen mit. Gespeicherte PDFs bleiben erhalten.

Prüfung: Der ergänzte Regressionstest schlug vor der Korrektur mit der bisherigen
Nummerierung fehl. `dart format lib test` und `flutter analyze` erfolgreich.
133 Evidence-/Paritätstests mit PDF-Textaudit unter UTC und 38 PDF-Inhalts-,
Layout- und Fotogittertests unter Europe/Berlin erfolgreich. Abgedeckt sind
absteigende Nummern, negative Fortschritte, kompakte Einträge, Einzelberichte
und fortgesetzte Fotozeilen mit bis zu zwölf Fotos.

Gerät: Die angeschlossene Dev-App wurde per Hot Reload aktualisiert. Der geladene
PDF-Service stimmt mit dem korrigierten Quelltext überein. Keine APK gebaut oder
installiert. Auf Nutzerwunsch die zusätzliche visuelle Bestätigung beendet,
bevor ein neues PDF erzeugt wurde. Die Änderung gilt für neu erstellte PDFs in
der laufenden Sitzung und ist noch nicht Bestandteil der installierten APK.
