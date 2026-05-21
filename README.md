# Hra Newton

Webová hra s fialovým kruhem ovládaným čtyřmi motory. Cílem je posbírat všechny mince na hrací ploše bez nárazu do zelených stěn.

## Spuštění

### Online (GitHub Pages)

**[Spustit hru](https://frantisekvvb.github.io/hra_newton/)**

### Přímo v prohlížeči

Otevři soubor `index.html` (dvojklik ve Finderu).

### Lokální server (doporučeno)

```bash
cd hra_newton
python3 -m http.server 8000
```

Poté otevři [http://localhost:8000](http://localhost:8000).

## Ovládání

- **Šipky** na klávesnici nebo **D-pad** vlevo od plochy — motory urychlují kruh opačným směrem (raketa na straně kruhu).
- **Nová hra** — náhodné rozložení stěn a mincí.
- **Hmotnost** — posuvník mění hmotnost, barvu kruhu (světlá → tmavá fialová) a zrychlení.
- **Tření** — zapnuto/vypnuto; při zapnutém tření zůstává za kruhem trvalá fialová šmouha.

## Pravidla

- Náraz do zelené stěny = výbuch, restart kola na začáteční pozici.
- Sběr všech mincí = výhra.
- Kruh může přes okraj plochy přejít na protější stranu.
- Maximální rychlost: 10 000.

## Technologie

Jednosouborová hra v HTML5 Canvas (bez závislostí).

## Zápis rekordního času do Google Tabulky

Do tabulky se zapisuje **jen nový rekord** — po odeslání přezdívky v levém panelu (sloupce `čas` | `přezdívka`).

Tabulka: [rekord – Google Sheets](https://docs.google.com/spreadsheets/d/1sfEULq5fP-q2KIosgMEx9iyMDZg150kqqgUt7LxFOnw/edit?usp=sharing)

### Nastavení (automaticky)

V tabulce nech hlavičku: **čas** | **přezdívka**. Pak v terminálu (jednorázové přihlášení Google účtem vlastníka tabulky):

```bash
cd ~/Documents/dev2/hra_newton
./scripts/deploy-rekord.sh
```

Skript nasadí `google-apps-script/ZapisCasu.gs`, vytvoří webovou aplikaci a zapíše URL do `RACE_SHEET_LOG_URL` v `index.html`. Potom `git push`.

### Nastavení (ručně)

1. Tabulka → **Rozšíření → Apps Script** → vlož `google-apps-script/ZapisCasu.gs`
2. **Nasadit → Webová aplikace** (Já / Kdokoli)
3. URL `/exec` do `RACE_SHEET_LOG_URL` v `index.html`

### Rekord v levém panelu

V `index.html` uprav `RACE_RECORD_SEC` (např. `40.28`) a `RACE_RECORD_NAME` (např. `František`). Po lepším čase se zobrazí formulář s přezdívkou; zápis do tabulky proběhne až po **Odeslat**.

### Poznámky

- Bez vyplněné `RACE_SHEET_LOG_URL` se nic neodesílá.
- URL skriptu je veřejná v kódu hry — volitelně použij `LOG_TOKEN` ve vlastnostech skriptu.

## Nahrání na GitHub

V terminálu:

```bash
cd ~/Documents/dev2/hra_newton
git init
git add .
git commit -m "Initial commit: Hra Newton"
gh repo create hra_newton --public --source=. --push
```

(Příkaz `gh repo create` vyžaduje nainstalované [GitHub CLI](https://cli.github.com/) a přihlášení `gh auth login`. Repozitář můžeš také vytvořit ručně na github.com a propojit ho přes `git remote add origin …`.)

## Licence

Volné použití pro výuku a osobní účely.
