
# Brute Force Script

Dieses Skript führt einen Brute-Force-Angriff gegen eine spezifische Ziel-URL durch, um Benutzernamen und Passwörter zu testen. Das Skript unterstützt sowohl die Verwendung einzelner Benutzername/Passwort-Kombinationen als auch Listen von Benutzernamen und Passwörtern.

## Voraussetzungen

- Bash (Unix/Linux oder Git Bash auf Windows)
- `curl` zum Senden der HTTP-Anfragen
- GNU Parallel (optional, für parallele Verarbeitung)

## Installation

1. GNU Parallel installieren (optional, aber empfohlen):

    ```bash
    sudo apt-get install parallel
    ```

2. Skript ausführbar machen:

    ```bash
    chmod +x dein_skript.sh
    ```

## Verwendung

1. Starten des Skripts:

    ```bash
    ./dein_skript.sh
    ```

2. Benutzereingaben:
    - Ziel-URL: Die URL der Webseite, gegen die der Brute-Force-Angriff ausgeführt werden soll (z.B. https://example.com).
    - Name der Logdatei: Der Name der Datei, in der die Ergebnisse gespeichert werden.
    - Benutzername: Einzelner Benutzername oder Pfad zu einer Datei mit Benutzernamen (leer lassen, um eine Benutzerliste zu verwenden).
    - Passwort: Einzelnes Passwort oder Pfad zu einer Datei mit Passwörtern (leer lassen, um eine Passwortliste zu verwenden).

3. Skript-Ablauf:
    - Das Skript initialisiert eine Logdatei.
    - Es führt eine Testanfrage durch, um die Erfolgsnachricht zu ermitteln.
    - Wenn eine Benutzerliste und Passwortliste angegeben sind, führt das Skript den Brute-Force-Angriff in paralleler Verarbeitung durch.
    - Die Ergebnisse werden in der Logdatei gespeichert.

## Beispiel

### Beispielausführung mit einzelnen Benutzernamen und Passwort:

```bash
./dein_skript.sh
```
```
Geben Sie die Ziel-URL ein (z.B. https://example.com): https://example.com/login
Geben Sie den Namen der Logdatei ein: logfile.txt
Geben Sie den Benutzernamen ein (leer lassen für Benutzerliste): admin
Geben Sie das Passwort ein (leer lassen für Passwortliste): password123
```

### Beispielausführung mit Benutzer- und Passwortlisten:

```bash
./dein_skript.sh
```
```
Geben Sie die Ziel-URL ein (z.B. https://example.com): https://example.com/login
Geben Sie den Namen der Logdatei ein: logfile.txt
Geben Sie den Benutzernamen ein (leer lassen für Benutzerliste):
Geben Sie den Pfad zur Benutzerliste ein: users.txt
Geben Sie das Passwort ein (leer lassen für Passwortliste):
Geben Sie den Pfad zur Passwortliste ein: passwords.txt
```

## Ausgabe

- **Logdatei**: Enthält alle erfolgreichen und fehlgeschlagenen Anmeldeversuche.
- **Konsolenausgabe**: Zeigt die automatisch erkannte Erfolgsnachricht und den Fortschritt des Skripts an.

## Hinweise

- Stellen Sie sicher, dass `curl` und GNU Parallel (falls verwendet) korrekt installiert sind.
- Das Skript sollte in einer sicheren und kontrollierten Umgebung verwendet werden. Unbefugtes Durchführen von Brute-Force-Angriffen ist illegal und strafbar.
