#!/bin/bash

# Note that JHBUILD_SOURCES should be defined to contain the path to the root
# of the jhbuild sources. The script assumes that it resides in the
# tools/gen_scripts/ directory and the XML file will be placed in gtk/src.

if [ -z "$JHBUILD_SOURCES" ]; then
  echo -e "JHBUILD_SOURCES must contain the path to the jhbuild sources."
  exit 1;
fi

PREFIX="$JHBUILD_SOURCES"
ROOT_DIR="$(dirname "$0")/../.."
OUT_DIR="$ROOT_DIR/gtk/src"

PARAMS="--with-properties --no-recursion"
for dir in "$PREFIX"/gtk+/{gtk,gtk/deprecated} "$PREFIX"/gtk+/build/gtk; do
  if [ -d "$dir" ]; then
    PARAMS="$PARAMS -s $dir"
  fi
done

DOCEXTRACT_TO_XML_PY="$JHBUILD_SOURCES/glibmm/tools/defs_gen/docextract_to_xml.py"
$DOCEXTRACT_TO_XML_PY $PARAMS > "$OUT_DIR/gtk_docs.xml"
