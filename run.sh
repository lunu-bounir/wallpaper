#! /bin/bash
npm install vue-cli

./expect.sh

rm -r build/src/
cp -r development/* build

cd build/
npm install
npm run build

ls dist
