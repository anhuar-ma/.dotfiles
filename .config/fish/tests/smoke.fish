#!/usr/bin/env fish
#
# Smoke tests for the fish-prompt-improvements spec.
#
# Run with:
#     fish ~/.config/fish/tests/smoke.fish
#
# Exits 0 when every assertion passes, 1 otherwise.
#
# This script relies on fish's normal function autoloading from
# ~/.config/fish/functions/, so the modified `_prompt_pwd_smart`,
# `prompt-mode`, and `fish_prompt` functions are picked up
# automatically.  Existing universal-variable state for
# `__fish_prompt_mode` is saved at the top and restored at the
# bottom, so running the script does not leave the user's shell in
# a different mode than it started.
#
# ----------------------------------------------------------------------
# Manual smoke checklist (from design.md → Testing Strategy).
# Run these by hand in an interactive shell after the automated
# assertions below all pass:
#
#   - `cd ~ && fish_prompt | head -1` includes `~` in the path segment.
#   - `cd ~/.config && fish_prompt` shows `~/.config`.
#   - `cd /tmp && fish_prompt` shows `/tmp`.
#   - `prompt-mode git; cd /tmp; <new prompt>` renders the two-line
#     git-style frame.
#   - `prompt-mode default; cd /tmp; <new prompt>` reverts to the
#     minimal prompt.
# ----------------------------------------------------------------------

# --- Save and clean universal-variable state -------------------------
set -g _smoke_had_mode 0
set -g _smoke_saved_mode ''
if set -q __fish_prompt_mode
    set _smoke_had_mode 1
    set _smoke_saved_mode $__fish_prompt_mode
end
set -e __fish_prompt_mode

# --- Tiny assertion helpers ------------------------------------------
set -g _smoke_fail 0

function _ok
    echo "  ok    $argv"
end

function _fail
    echo "  FAIL  $argv"
    set -g _smoke_fail (math $_smoke_fail + 1)
end

function _assert_eq --argument-names actual expected msg
    if test "$actual" = "$expected"
        _ok "$msg"
    else
        _fail "$msg (got: '$actual', want: '$expected')"
    end
end

function _assert_status --argument-names actual expected msg
    if test "$actual" -eq "$expected"
        _ok "$msg"
    else
        _fail "$msg (got status $actual, want $expected)"
    end
end

function _assert_match --argument-names value pattern msg
    if string match -q -- $pattern $value
        _ok "$msg"
    else
        _fail "$msg (got: '$value', expected match: '$pattern')"
    end
end

function _assert_no_match --argument-names value pattern msg
    if string match -q -- $pattern $value
        _fail "$msg (got: '$value', should NOT match: '$pattern')"
    else
        _ok "$msg"
    end
end

function _assert_nonempty --argument-names value msg
    if test -n "$value"
        _ok "$msg"
    else
        _fail "$msg (value was empty)"
    end
end

# --- Property 1, 2, 3: _prompt_pwd_smart -----------------------------
echo "[Property 1/2/3] _prompt_pwd_smart"

# Property 1: at $HOME → exactly "~"
pushd $HOME >/dev/null
set -l out (_prompt_pwd_smart)
_assert_eq "$out" "~" "Property 1: _prompt_pwd_smart at \$HOME returns '~'"
popd >/dev/null

# Property 2: under $HOME → starts with "~/"
set -l home_subdir (mktemp -d "$HOME/.smoke-test.XXXXXX")
pushd $home_subdir >/dev/null
set -l out (_prompt_pwd_smart)
_assert_match "$out" '~/*' "Property 2: _prompt_pwd_smart under \$HOME starts with '~/'"
popd >/dev/null
rm -rf $home_subdir

# Property 3: outside $HOME → starts with "/" and contains no "~"
set -l outside_dir (mktemp -d /tmp/smoke-test.XXXXXX)
pushd $outside_dir >/dev/null
set -l out (_prompt_pwd_smart)
_assert_match "$out" '/*' "Property 3a: _prompt_pwd_smart outside \$HOME starts with '/'"
_assert_no_match "$out" '*~*' "Property 3b: _prompt_pwd_smart outside \$HOME contains no '~'"
popd >/dev/null
rm -rf $outside_dir

# --- prompt-mode exit codes ------------------------------------------
echo "[prompt-mode] argument validation"

prompt-mode git >/dev/null 2>&1
_assert_status $status 0 "prompt-mode git exits 0"

prompt-mode default >/dev/null 2>&1
_assert_status $status 0 "prompt-mode default exits 0"

prompt-mode toggle >/dev/null 2>&1
_assert_status $status 0 "prompt-mode toggle exits 0"

prompt-mode >/dev/null 2>&1
_assert_status $status 0 "prompt-mode (no args) exits 0"

prompt-mode bogus >/dev/null 2>&1
_assert_status $status 2 "prompt-mode bogus exits 2"

# --- Property 6: toggle is involutive --------------------------------
echo "[Property 6] toggle is involutive"

set -U __fish_prompt_mode default
prompt-mode toggle >/dev/null
prompt-mode toggle >/dev/null
_assert_eq "$__fish_prompt_mode" "default" "Property 6a: two toggles from 'default' restore 'default'"

set -U __fish_prompt_mode git
prompt-mode toggle >/dev/null
prompt-mode toggle >/dev/null
_assert_eq "$__fish_prompt_mode" "git" "Property 6b: two toggles from 'git' restore 'git'"

# --- Property 4 & 5: fish_prompt non-empty in each mode outside repo -
echo "[Property 4/5] fish_prompt non-empty outside a repo"

# Use a fresh /tmp dir guaranteed to be outside any git work tree.
set -l norepo (mktemp -d /tmp/smoke-norepo.XXXXXX)
pushd $norepo >/dev/null

set -U __fish_prompt_mode git
set -l p (fish_prompt 2>/dev/null)
_assert_nonempty "$p" "Property 4: fish_prompt with mode=git outside a repo is non-empty"

set -U __fish_prompt_mode default
set -l p (fish_prompt 2>/dev/null)
_assert_nonempty "$p" "Property 5a: fish_prompt with mode=default outside a repo is non-empty"

set -e __fish_prompt_mode
set -l p (fish_prompt 2>/dev/null)
_assert_nonempty "$p" "Property 5b: fish_prompt with mode unset outside a repo is non-empty"

popd >/dev/null
rm -rf $norepo

# --- Restore original universal-variable state -----------------------
set -e __fish_prompt_mode
if test $_smoke_had_mode -eq 1
    set -U __fish_prompt_mode $_smoke_saved_mode
end

# --- Summary ---------------------------------------------------------
echo
if test $_smoke_fail -eq 0
    echo "smoke: all assertions passed"
    exit 0
else
    echo "smoke: $_smoke_fail assertion(s) failed"
    exit 1
end
