/**
 * Zápis rekordního času do tabulky „rekord“.
 * Tabulka: https://docs.google.com/spreadsheets/d/1sfEULq5fP-q2KIosgMEx9iyMDZg150kqqgUt7LxFOnw/
 * Sloupce A: čas | B: přezdívka (řádek 1 = hlavička)
 *
 * 1. Otevři tabulku → Rozšíření → Apps Script, vlož tento kód, ulož
 * 2. Nasadit → Nové nasazení → Webová aplikace
 *    - Spouštět jako: Já
 *    - Kdo má přístup: Kdokoli
 * 3. URL nasazení (/exec) vlož do RACE_SHEET_LOG_URL v index.html
 */

const SHEET_ID = '1sfEULq5fP-q2KIosgMEx9iyMDZg150kqqgUt7LxFOnw';

function doGet(e) {
  const p = e.parameter || {};
  const expected = PropertiesService.getScriptProperties().getProperty('LOG_TOKEN');
  if (expected && p.token !== expected) {
    return ContentService.createTextOutput('forbidden')
      .setMimeType(ContentService.MimeType.TEXT);
  }

  const cas = (p.cas || '').trim();
  const prezdivka = (p.prezdivka || '').trim();
  if (!cas || !prezdivka) {
    return ContentService.createTextOutput('missing')
      .setMimeType(ContentService.MimeType.TEXT);
  }

  const sheet = SpreadsheetApp.openById(SHEET_ID).getSheets()[0];
  sheet.appendRow([cas, prezdivka]);

  return ContentService.createTextOutput('ok')
    .setMimeType(ContentService.MimeType.TEXT);
}
