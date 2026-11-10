#!/usr/bin/env python3
"""
NeuroCall Pre-Commit Hardware & Asset Containment Gate
Enforces:
  1. Mass-Deletion Gate: Blocks commits deleting >80 lines in a single .swift file or >120 total .swift lines.
  2. Image Provenance Lock: Blocks staged images in Assets.xcassets/, RadixApp/Assets/, or emulator/assets/
     unless their SHA-256 matches an approved baseline hash or a user-supplied file in ScreenDrop/uploads,
     ~/Downloads, or .user_uploaded (or DR_MOHIT_APPROVE_IMAGE=1 after explicit user sign-off).
  3. Swift Pre-Flight Gate: Verifies 100% bracket balance and checks that all ObsidianTheme.<member> references
     exist in ObsidianTheme.swift before allowing a commit.
"""

import hashlib
import json
import os
import re
import subprocess
import sys

REPO_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
MANIFEST_PATH = os.path.join(REPO_ROOT, "scripts", "approved_assets_manifest.json")

USER_SUPPLY_DIRS = [
    r"C:\Users\mohal\Documents\antigravity\ScreenDrop\uploads",
    r"C:\Users\mohal\Downloads",
    r"C:\Users\mohal\.gemini\antigravity\brain",
]

MAX_SINGLE_FILE_SWIFT_DELETIONS = 80
MAX_TOTAL_SWIFT_DELETIONS = 120


def sha256_file(path: str) -> str:
    h = hashlib.sha256()
    with open(path, "rb") as f:
        for chunk in iter(lambda: f.read(65536), b""):
            h.update(chunk)
    return h.hexdigest()


def collect_user_supplied_hashes() -> set:
    hashes = set()
    for base in USER_SUPPLY_DIRS:
        if not os.path.exists(base):
            continue
        if base.endswith("brain"):
            # Only scan .user_uploaded folders inside brain conversations
            for root, dirs, files in os.walk(base):
                if ".user_uploaded" in root:
                    for fn in files:
                        fp = os.path.join(root, fn)
                        if os.path.isfile(fp) and fn.lower().endswith((".jpg", ".jpeg", ".png", ".webp")):
                            try:
                                hashes.add(sha256_file(fp))
                            except OSError:
                                pass
        else:
            # Top-level files in ScreenDrop/uploads and ~/Downloads
            try:
                for fn in os.listdir(base):
                    fp = os.path.join(base, fn)
                    if os.path.isfile(fp) and fn.lower().endswith((".jpg", ".jpeg", ".png", ".webp")):
                        try:
                            hashes.add(sha256_file(fp))
                        except OSError:
                            pass
            except OSError:
                pass
    return hashes


def check_mass_deletions() -> list:
    errors = []
    if os.environ.get("DR_MOHIT_UNLOCK_CODE") == "1":
        return errors

    res = subprocess.run(
        ["git", "-C", REPO_ROOT, "diff", "--cached", "--numstat", "--", "*.swift"],
        capture_output=True,
        text=True,
    )
    total_deleted = 0
    for line in res.stdout.splitlines():
        parts = line.split("\t")
        if len(parts) < 3:
            continue
        added_s, deleted_s, filepath = parts[0], parts[1], parts[2]
        if deleted_s == "-":
            continue
        deleted = int(deleted_s)
        total_deleted += deleted
        if deleted > MAX_SINGLE_FILE_SWIFT_DELETIONS:
            errors.append(
                f"[MASS-DELETION GATE BLOCKED] {filepath} deletes {deleted} lines "
                f"(limit: {MAX_SINGLE_FILE_SWIFT_DELETIONS}). "
                f"To override after Dr. Mohit's explicit approval, set DR_MOHIT_UNLOCK_CODE=1."
            )
    if total_deleted > MAX_TOTAL_SWIFT_DELETIONS:
        errors.append(
            f"[MASS-DELETION GATE BLOCKED] Commit deletes {total_deleted} total Swift lines "
            f"(limit: {MAX_TOTAL_SWIFT_DELETIONS}). "
            f"To override after Dr. Mohit's explicit approval, set DR_MOHIT_UNLOCK_CODE=1."
        )
    return errors


def check_image_provenance() -> list:
    errors = []
    if os.environ.get("DR_MOHIT_APPROVE_IMAGE") == "1":
        return errors

    res = subprocess.run(
        ["git", "-C", REPO_ROOT, "diff", "--cached", "--name-only", "--diff-filter=ACMR"],
        capture_output=True,
        text=True,
    )
    staged_files = [f.strip() for f in res.stdout.splitlines() if f.strip()]
    protected_prefixes = ("Assets.xcassets/", "RadixApp/Assets/", "emulator/assets/")
    staged_images = [
        f for f in staged_files
        if f.startswith(protected_prefixes) and f.lower().endswith((".jpg", ".jpeg", ".png", ".webp"))
    ]
    if not staged_images:
        return errors

    approved_hashes = set()
    if os.path.exists(MANIFEST_PATH):
        try:
            with open(MANIFEST_PATH, "r", encoding="utf-8") as mf:
                data = json.load(mf)
                approved_hashes.update(data.get("hashes", {}).values())
        except Exception:
            pass

    user_hashes = collect_user_supplied_hashes()
    allowed_hashes = approved_hashes | user_hashes

    for rel_path in staged_images:
        abs_path = os.path.join(REPO_ROOT, rel_path)
        if not os.path.exists(abs_path):
            continue
        file_hash = sha256_file(abs_path)
        if file_hash not in allowed_hashes:
            errors.append(
                f"[IMAGE CONTAINMENT LOCK BLOCKED] '{rel_path}' (sha256: {file_hash[:12]}...) "
                f"does NOT match any approved baseline asset or any user-supplied image in "
                f"ScreenDrop/uploads, ~/Downloads, or .user_uploaded. "
                f"AI-generated or OpenCV-inpainted images cannot be committed without Dr. Mohit's explicit approval "
                f"(DR_MOHIT_APPROVE_IMAGE=1)."
            )
    return errors


def check_swift_syntax_and_theme() -> list:
    errors = []
    swift_root = os.path.join(REPO_ROOT, "RadixApp")
    theme_file = os.path.join(swift_root, "Views", "ObsidianTheme.swift")

    defined_theme_members = set()
    if os.path.exists(theme_file):
        with open(theme_file, "r", encoding="utf-8", errors="ignore") as tf:
            theme_code = tf.read()
            for m in re.finditer(r"static\s+(?:let|var|func)\s+([a-zA-Z0-9_]+)", theme_code):
                defined_theme_members.add(m.group(1))

    for root, _, files in os.walk(swift_root):
        for fn in files:
            if not fn.endswith(".swift"):
                continue
            fp = os.path.join(root, fn)
            with open(fp, "r", encoding="utf-8", errors="ignore") as sf:
                code = sf.read()

            # Check ObsidianTheme references
            if defined_theme_members:
                for m in re.finditer(r"ObsidianTheme\.([a-zA-Z0-9_]+)", code):
                    member = m.group(1)
                    if member not in defined_theme_members:
                        errors.append(
                            f"[SWIFT THEME GATE BLOCKED] {fn} references undefined 'ObsidianTheme.{member}'."
                        )

            # Check bracket balance (ignoring comments and strings)
            i, n = 0, len(code)
            clean = []
            while i < n:
                if code[i:i+2] == "//":
                    while i < n and code[i] != "\n":
                        i += 1
                elif code[i:i+2] == "/*":
                    i += 2
                    while i < n - 1 and code[i:i+2] != "*/":
                        i += 1
                    i += 2
                elif code[i] == '"':
                    if code[i:i+3] == '"""':
                        i += 3
                        while i < n - 2 and code[i:i+3] != '"""':
                            i += 1
                        i += 3
                    else:
                        i += 1
                        while i < n and code[i] != '"':
                            if code[i] == "\\":
                                i += 2
                            else:
                                i += 1
                        i += 1
                else:
                    if code[i] in "(){}[]":
                        clean.append((code[i], i))
                    i += 1
            stack = []
            pairs = {")": "(", "}": "{", "]": "["}
            for ch, pos in clean:
                if ch in "({[":
                    stack.append((ch, pos))
                else:
                    if not stack:
                        errors.append(f"[SWIFT SYNTAX GATE BLOCKED] {fn}: Unmatched '{ch}' at offset {pos}")
                        break
                    top, top_pos = stack.pop()
                    if top != pairs[ch]:
                        errors.append(
                            f"[SWIFT SYNTAX GATE BLOCKED] {fn}: Mismatched '{top}' ({top_pos}) and '{ch}' ({pos})"
                        )
                        break
            if stack:
                errors.append(f"[SWIFT SYNTAX GATE BLOCKED] {fn}: {len(stack)} unclosed delimiter(s)")
    return errors


def main() -> int:
    all_errors = []
    all_errors.extend(check_mass_deletions())
    all_errors.extend(check_image_provenance())
    all_errors.extend(check_swift_syntax_and_theme())

    if all_errors:
        print("=" * 78, file=sys.stderr)
        print("🛑 NEUROCALL PRE-COMMIT CONTAINMENT GATE REJECTED THIS COMMIT:", file=sys.stderr)
        print("=" * 78, file=sys.stderr)
        for err in all_errors:
            print(f"  • {err}", file=sys.stderr)
        print("=" * 78, file=sys.stderr)
        return 1

    print("[NeuroCall Pre-Commit Gate] OK: Asset provenance, deletion limits, and Swift syntax verified.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
