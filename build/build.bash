#!/usr/bin/env bash

set -e

mkdir -p public/fonts

curl -L https://github.com/KDE/oxygen-fonts/archive/v5.4.3.tar.gz | tar xz
mv oxygen-fonts-5.4.3/oxygen-fonts/mono-400/OxygenMono-Regular.ttf public/fonts/oxygen-mono.ttf

curl -L https://github.com/cyrealtype/Lora-Cyrillic/releases/download/v2.202/LoraGX.ttf --output public/fonts/lora.ttf
curl -L https://github.com/cyrealtype/Lora-Cyrillic/releases/download/v2.202/LoraItalicGX.ttf --output public/fonts/lora-italic.ttf

curl -L https://github.com/Omnibus-Type/Asap/raw/master/fonts/webfonts/woff2/Asap-Italic.woff2 --output public/fonts/asap-italic.woff2

cp style.css public
cp not-found/main.svg public/not-found.svg
cp not-found/main.html public/not_found.html

npx google-closure-compiler@20200517.0.0 \
	--module_resolution=NODE \
	--dependency_mode=PRUNE \
	--process_common_js_modules \
	--entry_point=script.js script.js \
	'node_modules/**.{mjs,js,esm,cjs,json}' \
	'scripts/*' \
	--language_out=ECMASCRIPT_2019 \
	--js_output_file public/script.js

yarn licenses generate-disclaimer > public/licenses.txt

node build/build.js

cd public
find . -type f | sed -e 's/^.*$/-F \0=@\0/' | xargs curl "https://$neocities_auth@neocities.org/api/upload"