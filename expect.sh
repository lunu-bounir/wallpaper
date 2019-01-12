#!/usr/bin/expect
set timeout 10

spawn ./node_modules/vue-cli/bin/vue init browserify-simple build

expect "Generate project in current directory?"
send "y\r"
expect "downloading template"
send "\r"
expect "Project name"
send "\r"
expect "Project description"
send "\r"
expect "Author"
send "\r"
expect "Generated"
send "\r"

interact
