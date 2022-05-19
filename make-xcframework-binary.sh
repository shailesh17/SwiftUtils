#!/usr/bin/env bash

START_TS=$(date '+%Y%m%d-%H%M%S')
SCRIPT_NAME="$0"
ARGS="$*"

CONFIGURATION="Debug"
if [[ $1 == "Release" ]]; then
    CONFIGURATION="Release"
fi

XCPROJECT_PATH="./SwiftUtilsXCFramework/SwiftUtilsXCFramework.xcodeproj"
SCHEME_NAME="SwiftUtilsXCFramework"

BUILD_DIR="./.build"
DIST_DIR="./dist"

if [[ ! -d "${XCPROJECT_PATH}" ]]; then
    echo "${XCPROJECT_PATH} not found"
    exit 1
fi

echo "${SCRIPT_NAME} ${START_TS} Cleaning up previous build...."
rm -rf "${BUILD_DIR}"/*

set -e
mkdir -p "${BUILD_DIR}/archives"
mkdir -p "${BUILD_DIR}/products"

set -xv
xcrun xcodebuild archive \
-project "${XCPROJECT_PATH}" \
-scheme "${SCHEME_NAME}" \
-configuration ${CONFIGURATION} \
-destination 'generic/platform=iOS Simulator' \
-archivePath "${BUILD_DIR}/archives/${SCHEME_NAME}-iphonesimulator.xcarchive" \
SKIP_INSTALL=NO \
BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

xcrun xcodebuild archive \
-project "${XCPROJECT_PATH}" \
-scheme "${SCHEME_NAME}" \
-configuration ${CONFIGURATION} \
-destination 'generic/platform=iOS' \
-archivePath "${BUILD_DIR}/archives/${SCHEME_NAME}-iphoneos.xcarchive" \
SKIP_INSTALL=NO \
BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

xcrun xcodebuild -create-xcframework \
-archive  "${BUILD_DIR}/archives/${SCHEME_NAME}-iphonesimulator.xcarchive" \
-framework "${SCHEME_NAME}.framework" \
-archive "${BUILD_DIR}/archives/${SCHEME_NAME}-iphoneos.xcarchive" \
-framework "${SCHEME_NAME}.framework" \
-output "${BUILD_DIR}/products/${SCHEME_NAME}.xcframework"
set +xv

cd "${BUILD_DIR}/products"
zip -r9 ./${SCHEME_NAME}.zip ./${SCHEME_NAME}.xcframework
shasum  -a 256 ${SCHEME_NAME}.zip >> ./${SCHEME_NAME}.zip.shasum
cd ../..

rm -rf "${DIST_DIR}"/*
mkdir -p "${DIST_DIR}"
mv "${BUILD_DIR}/products/${SCHEME_NAME}.zip" "${DIST_DIR}/"
mv "${BUILD_DIR}/products/${SCHEME_NAME}.zip.shasum" "${DIST_DIR}/"

END_TS=$(date '+%Y%m%d-%H%M%S')
echo "${SCRIPT_NAME} ${END_TS} Completed, output in ${DIST_DIR}/${SCHEME_NAME}.zip ...."
