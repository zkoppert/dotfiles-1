Building from source
If your operating system does not have a binary release, but does run Go, you can build from source.

Make sure that you have Go version 1.11 or greater and Go modules are enabled.

git clone https://github.com/zyedidia/micro
cd micro
make build
sudo mv micro /usr/local/bin # optional
