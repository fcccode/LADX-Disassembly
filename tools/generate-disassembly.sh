#!/bin/sh -ex
# Generate a disassembly of the whole ROM,
# using the debug symbols already documented in the partial disassembly.

TOOLS_DIR=$(dirname "$0")
ROOT_DIR="$TOOLS_DIR/.."
cd "$ROOT_DIR"

# Generate the ROM and the debug symbols if not found
if ! [[ -f game.gbc ]] || ! [[ -f game.sym ]]; then
  make
fi

# Retrieve the disassembler submodule if not initialized yet
if ! [[ -f tools/mgbdis/mgbdis.py ]]; then
  git submodule update --init
fi

# Invoke the disassembler with the specific formatting options
tools/mgbdis/mgbdis.py game.gbc --overwrite --print-hex --uppercase-hex --align-operands
