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
