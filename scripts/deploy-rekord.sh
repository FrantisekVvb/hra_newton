#!/bin/bash
# Nasadí ZapisCasu.gs do tabulky „rekord“ a zapíše URL do index.html
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
GAS_DIR="$ROOT/google-apps-script"
SHEET_ID="1sfEULq5fP-q2KIosgMEx9iyMDZg150kqqgUt7LxFOnw"
CLASP="npx --yes @google/clasp"

cd "$GAS_DIR"

if ! $CLASP show-authorized-user 2>&1 | grep -qi "logged in"; then
  echo "→ Přihlas se v prohlížeči (Google účet vlastníka tabulky)."
  $CLASP login
fi

if [[ ! -f .clasp.json ]] || ! grep -q '"scriptId"' .clasp.json || grep -q '"scriptId": ""' .clasp.json; then
  echo "→ Vytvářím Apps Script projekt navázaný na tabulku…"
  $CLASP create --type sheets --title "ZapisRekordu" --parentId "$SHEET_ID" --rootDir .
fi

echo "→ Nahrávám kód…"
$CLASP push --force

echo "→ Nasazuji webovou aplikaci…"
DEPLOY_JSON=$($CLASP deploy --description "web" --json 2>/dev/null || true)
DEPLOY_ID=""
if [[ -n "$DEPLOY_JSON" ]]; then
  DEPLOY_ID=$(echo "$DEPLOY_JSON" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('deploymentId',''))" 2>/dev/null || true)
fi

WEB_URL=""
while read -r line; do
  if [[ "$line" == *"script.google.com/macros/s/"*"/exec"* ]]; then
    WEB_URL="$line"
    break
  fi
done < <($CLASP deployments --json 2>/dev/null | python3 -c "
import json,sys
try:
  data=json.load(sys.stdin)
  for d in data if isinstance(data,list) else []:
    u=d.get('webApp',{}).get('url') or d.get('webapp',{}).get('url')
    if u: print(u)
except Exception:
  pass
" 2>/dev/null || $CLASP deployments 2>/dev/null)

if [[ -z "$WEB_URL" && -n "$DEPLOY_ID" ]]; then
  SCRIPT_ID=$(python3 -c "import json; print(json.load(open('.clasp.json'))['scriptId'])")
  WEB_URL="https://script.google.com/macros/s/${DEPLOY_ID}/exec"
fi

if [[ -z "$WEB_URL" ]]; then
  SCRIPT_ID=$(python3 -c "import json; print(json.load(open('.clasp.json'))['scriptId'])")
  echo ""
  echo "Nasazení hotové. Otevři Apps Script → Nasadit → spravovat nasazení"
  echo "a zkopíruj URL webové aplikace (/exec) do index.html:"
  echo "  https://script.google.com/home/projects/${SCRIPT_ID}/settings"
  exit 1
fi

echo "→ URL: $WEB_URL"
python3 <<PY
from pathlib import Path
import re
root = Path("$ROOT")
html = root / "index.html"
text = html.read_text(encoding="utf-8")
text = re.sub(
    r"const RACE_SHEET_LOG_URL = '[^']*';",
    f"const RACE_SHEET_LOG_URL = '{WEB_URL}';",
    text,
    count=1,
)
html.write_text(text, encoding="utf-8")
print("→ Zapsáno do index.html")
PY

echo "Hotovo."
