#!/bin/bash

set -e
set -x

package="libindy"
PACKAGE="${package}.a"
TYPE="release"
WORK_DIR="out_pod"

export PKG_CONFIG_ALLOW_CROSS=1
export LIBINDY_POD_VERSION=1.16.0

if [ -z "${OPENSSL_DIR}" ]; then
  export OPENSSL_DIR=$(brew --prefix openssl@1.1)
fi

if [ ! -d "${OPENSSL_DIR}" ]; then
  echo "OpenSSL not found. Try brew install openssl@1.1"
  exit 1
fi

echo "Build IOS xcframework started..."

cd ${package}

if [ -d $WORK_DIR ]; then
  rm -r $WORK_DIR
fi
mkdir $WORK_DIR
if [[ ! "$WORK_DIR" || ! -d "$WORK_DIR" ]]; then
  echo "Could not create temp dir $WORK_DIR"
  exit 1
fi

function copy_target() {
  local target=$1

  mkdir -p $WORK_DIR/$target/include
  mkdir -p $WORK_DIR/$target/lib
  cp include/*.h $WORK_DIR/$target/include
  cp target/$target/$TYPE/$PACKAGE $WORK_DIR/$target/lib
}

echo -e "\nBuilding libraries..."
cargo build --$TYPE --target "aarch64-apple-ios"
copy_target "aarch64-apple-ios"
cargo build --$TYPE --target "aarch64-apple-ios"
CFLAGS_aarch64_apple_ios_sim="-target arm64-apple-ios7.0.0-simulator" cargo build --$TYPE --target aarch64-apple-ios-sim
copy_target "aarch64-apple-ios-sim"
CFLAGS_x86_64_apple_ios_sim="-target x86_64-apple-ios" cargo build --$TYPE --target x86_64-apple-ios
copy_target "x86_64-apple-ios"

echo -e "\nCreating simulator fat binary"
fat_sim="simulator_fat.a"
lipo -create $WORK_DIR/aarch64-apple-ios-sim/lib/$PACKAGE $WORK_DIR/x86_64-apple-ios/lib/$PACKAGE -output $WORK_DIR/$fat_sim

echo -e "\nCreating xcframework"
xcodebuild -create-xcframework \
  -library $WORK_DIR/aarch64-apple-ios/lib/$PACKAGE \
  -headers $WORK_DIR/aarch64-apple-ios/include \
  -library $WORK_DIR/$fat_sim \
  -headers $WORK_DIR/x86_64-apple-ios/include \
  -output $WORK_DIR/$package.xcframework

echo -e "\nBuild IOS xcframework finised"
