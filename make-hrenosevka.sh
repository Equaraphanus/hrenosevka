#!/bin/sh

cd 3rdparty/iosevka
npm install
PATH="$(ls -d node_modules/*/bin | tr '\n' ':')${PATH}" npm run build -- ttf::hrenosevka
