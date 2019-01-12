#! /bin/bash
./expect.sh

rm -r build/src/
cp -r development/* build

cd build/
npm install
npm run build

ls dist
