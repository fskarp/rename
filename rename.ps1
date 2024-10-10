# Definicja fraz do wyszukiwania i zamiany
$frazy = @("Linux Server", "Others","Windows Servers","Workstations")  # Można dodać więcej fraz w cudzysłowach

# Pobierz ścieżkę katalogu, w którym uruchomiono skrypt
$sciezka = Get-Location

# Przejrzyj wszystkie pliki w katalogu
Get-ChildItem -Path $sciezka -File | ForEach-Object {
    $plik = $_
    $nowaNazwa = $null

    # Sprawdź, czy nazwa pliku zawiera którąkolwiek z fraz
    foreach ($fraza in $frazy) {
        if ($plik.Name -like "*$fraza*") {
            # Jeśli fraza jest znaleziona, ustaw nową nazwę na fraza.xlsx
            $nowaNazwa = "$fraza.csv"
            break
        }
    }

    # Jeśli nowa nazwa jest ustawiona, zmień nazwę pliku
    if ($nowaNazwa) {
        $sciezkaNowaNazwa = Join-Path -Path $sciezka -ChildPath $nowaNazwa
        Rename-Item -Path $plik.FullName -NewName $sciezkaNowaNazwa -Force
        Write-Host "Zmieniono nazwę pliku '$($plik.Name)' na '$nowaNazwa'"
    }
    else {
        Write-Host "Nie znaleziono pasującej frazy dla pliku '$($plik.Name)'"
    }
}
