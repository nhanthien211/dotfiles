#!/usr/bin/env node
// Adds new default key bindings from the installed Herdr app to keys.json.
//
// Herdr treats keys.json as the whole keymap: it upgrades the file by itself
// only while it still matches the defaults it shipped. Once a binding is
// edited, new default shortcuts must be merged by hand — this script does it.
// Existing bindings are never changed; only missing ones are added.
//
// Usage:
//   node merge-keys.js              merge the installed app's defaults into keys.json
//   node merge-keys.js --dry-run    show what would be added
//   node merge-keys.js --app PATH   read defaults from another Herdr binary
//   node merge-keys.js --from FILE  read defaults from a keys JSON file instead
//   node merge-keys.js --keys FILE  target another keys.json
//
// No dependencies; runs on macOS, Linux and Windows.

"use strict";

const fs = require("fs");
const os = require("os");
const path = require("path");

const args = process.argv.slice(2);
const has = (name) => args.includes("--" + name);
const value = (name) => {
  const i = args.indexOf("--" + name);
  return i >= 0 && i + 1 < args.length ? args[i + 1] : undefined;
};

if (has("help") || args.includes("-h")) {
  const usage = fs.readFileSync(__filename, "utf8").split("\n").slice(2, 14).join("\n");
  console.log(usage.replace(/^\/\/ ?/gm, ""));
  process.exit(0);
}

const dryRun = has("dry-run");
const keysFile = path.resolve(value("keys") || path.join(__dirname, "keys.json"));
const liveKeys = path.join(os.homedir(), ".config", "herdr-app", "keys.json");

function fail(message) {
  console.error("merge-keys: " + message);
  process.exit(1);
}

function exists(file) {
  try {
    fs.accessSync(file);
    return true;
  } catch {
    return false;
  }
}

function readJson(file) {
  try {
    return JSON.parse(fs.readFileSync(file, "utf8"));
  } catch (error) {
    fail(`cannot read ${file}: ${error.message}`);
  }
}

function isObject(value) {
  return value !== null && typeof value === "object" && !Array.isArray(value);
}

function bindingCount(map) {
  return Object.values(map).reduce(
    (total, section) => total + (isObject(section) ? Object.keys(section).length : 0),
    0,
  );
}

// --- defaults -------------------------------------------------------------

// The shipped keymaps are embedded in the Herdr binary. Older releases stay
// embedded so Herdr can still recognise an untouched file from them, so pick
// the map with the most bindings: that is the current default set.
function defaultsFromBinary(binary) {
  const text = fs.readFileSync(binary).toString("latin1");
  const starts = [...text.matchAll(/\{\s*"global"\s*:/g)].map((match) => match.index);
  const candidates = [];

  for (const start of starts) {
    const end = matchingBrace(text, start);
    if (end < 0) continue;
    let parsed;
    try {
      parsed = JSON.parse(text.slice(start, end));
    } catch {
      continue;
    }
    if (!isObject(parsed) || !isObject(parsed.global) || !isObject(parsed.terminal)) continue;
    candidates.push(parsed);
  }

  if (candidates.length === 0) return null;
  candidates.sort((a, b) => bindingCount(b) - bindingCount(a));
  return candidates[0];
}

function matchingBrace(text, start) {
  let depth = 0;
  let inString = false;
  let escaped = false;
  for (let i = start; i < text.length; i++) {
    const char = text[i];
    if (inString) {
      if (escaped) escaped = false;
      else if (char === "\\") escaped = true;
      else if (char === '"') inString = false;
      continue;
    }
    if (char === '"') inString = true;
    else if (char === "{") depth++;
    else if (char === "}" && --depth === 0) return i + 1;
  }
  return -1;
}

function findApp() {
  const explicit = value("app") || process.env.HERDR_APP_BIN;
  const candidates = [explicit].filter(Boolean);
  const home = os.homedir();

  if (process.platform === "darwin") {
    candidates.push(
      path.join(home, ".local", "bin", "herdr-app"),
      path.join(home, "Applications", "Herdr.app", "Contents", "MacOS", "Herdr"),
      "/Applications/Herdr.app/Contents/MacOS/Herdr",
    );
  } else {
    candidates.push(path.join(home, ".local", "bin", "herdr-app"));
    const dirs = (process.env.PATH || "").split(path.delimiter).filter(Boolean);
    for (const dir of dirs) {
      candidates.push(path.join(dir, "herdr-app"), path.join(dir, "herdr-app.exe"));
    }
    if (process.platform === "win32" && process.env.LOCALAPPDATA) {
      candidates.push(
        path.join(process.env.LOCALAPPDATA, "Programs", "Herdr", "Herdr.exe"),
        path.join(process.env.LOCALAPPDATA, "Herdr", "Herdr.exe"),
      );
    }
  }

  for (const candidate of candidates) {
    try {
      const resolved = fs.realpathSync(candidate);
      if (fs.statSync(resolved).isFile()) return resolved;
    } catch {
      // try the next candidate
    }
  }
  return null;
}

function loadDefaults() {
  const from = value("from");
  if (from) {
    const parsed = readJson(path.resolve(from));
    if (!isObject(parsed) || !isObject(parsed.global)) fail(`${from} is not a keys.json file`);
    return { defaults: parsed, source: from };
  }

  const app = findApp();
  if (!app) {
    fail(
      "cannot find the Herdr app. Pass --app <path to herdr-app or Herdr binary>, " +
        "set HERDR_APP_BIN, or merge from a file with --from <keys.json>.",
    );
  }
  const defaults = defaultsFromBinary(app);
  if (!defaults) fail(`no default keymap found in ${app}; use --from <keys.json>`);
  return { defaults, source: app };
}

// --- merge ----------------------------------------------------------------

function merge(ours, defaults) {
  const result = JSON.parse(JSON.stringify(ours));
  const added = [];

  for (const section of Object.keys(defaults)) {
    if (!isObject(defaults[section])) continue;
    if (!isObject(result[section])) result[section] = {};
    for (const [key, action] of Object.entries(defaults[section])) {
      if (key in result[section]) continue;
      result[section][key] = action;
      added.push(`${section}: ${key} -> ${typeof action === "string" ? action : JSON.stringify(action)}`);
    }
  }
  return { result, added };
}

// --- writing --------------------------------------------------------------

function writeJson(file, value) {
  const mode = exists(file) ? fs.statSync(file).mode : 0o644;
  const temp = `${file}.tmp-${process.pid}`;
  fs.writeFileSync(temp, JSON.stringify(value, null, 2) + "\n", { mode });
  fs.chmodSync(temp, mode);
  fs.renameSync(temp, file);
}

function checkLiveLink() {
  if (!exists(liveKeys)) return;
  let stat;
  try {
    stat = fs.lstatSync(liveKeys);
  } catch {
    return;
  }
  if (stat.isSymbolicLink()) {
    try {
      if (fs.realpathSync(liveKeys) !== fs.realpathSync(keysFile)) {
        console.warn(`merge-keys: warning: ${liveKeys} links elsewhere; Herdr will not see this merge`);
      }
    } catch {
      console.warn(`merge-keys: warning: ${liveKeys} is a broken link; re-run the README link step`);
    }
    return;
  }
  if (!stat.isFile()) return;
  const same = fs.readFileSync(liveKeys, "utf8") === fs.readFileSync(keysFile, "utf8");
  if (same) {
    console.warn(
      `merge-keys: ${liveKeys} is a regular file, not a link to this repo.\n` +
        "  Move it aside and link the repo copy (see the Herdr section of README.md).",
    );
  } else {
    console.warn(
      `merge-keys: ${liveKeys} is a regular file with different bindings.\n` +
        "  Merging the repo copy only. Back up that file before replacing it with a link.",
    );
  }
}

// --- main -----------------------------------------------------------------

if (!exists(keysFile)) fail(`no keys.json at ${keysFile}`);
const ours = readJson(keysFile);
if (!isObject(ours)) fail(`${keysFile} is not a JSON object`);

const { defaults, source } = loadDefaults();
const { result, added } = merge(ours, defaults);

console.log(`Defaults: ${source} (${bindingCount(defaults)} bindings)`);
if (added.length === 0) {
  console.log("keys.json already has every default binding; nothing to add.");
  checkLiveLink();
  process.exit(0);
}

console.log(`Adding ${added.length} binding${added.length === 1 ? "" : "s"}:`);
for (const line of added) console.log("  " + line);

if (dryRun) {
  console.log("Dry run: keys.json was not changed.");
  process.exit(0);
}

writeJson(keysFile, result);
console.log(`Wrote ${keysFile}. Herdr applies it live.`);
checkLiveLink();
