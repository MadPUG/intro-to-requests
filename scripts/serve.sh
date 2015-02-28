#!/usr/bin/env sh
pushd build/slides
python3.4 -m http.server 8080
popd
