#!/usr/bin/env bash

# This script is designed to run from the makefile in the root of the project, and thus all paths will be anchored to
# the root of the project, not src. For that reason, there is no anchoring of the directory paths to the script
# directory using something like:
# scriptDir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Check if the required binary has been compiled
if [ ! -f brstm_converter ]; then
    echo "Please run 'make setup' to setup the project first."
    exit 1
fi

# Gather a list of files to convert, avoiding argument expansion faults with large amounts of files
filesToConvert=(`find in -maxdepth 1 -name "*.bwav"`)

# Get the amount of items in the array for sanity checking and helpful command progress output
amountOfFilesToConvert=${#filesToConvert[@]}

# Locale format the command output total amount of files number
amountOfFilesToConvertPretty=$(printf "%'.0f" ${amountOfFilesToConvert})

# Check if there is anything to convert
if [ ${amountOfFilesToConvert} -eq 0 ]; then
    echo "Nothing to convert. Please place your source *.bwav files in the 'in' directory first."
    exit 0
fi

# Setup a file index ticker, the alternative is to loop the keys in the array with ${!filesToConvert[@]} and instead
# call array elements when required with the index ${filesToConvert[$i]}. But a ticker seems cleaner...
currentFileIdx=0

# Convert shit
for inFilePath in ${filesToConvert[@]}; do
    # Increment the ticker
    ((currentFileIdx++))

    # Locale format the command output current file number
    currentFileIdxPretty=$(printf "%'.0f" ${currentFileIdx})

    # Using the current length of the finishing number, output and pad the current progress
    printf "┌[PROG] %${#amountOfFilesToConvertPretty}s / %s\n" ${currentFileIdxPretty} ${amountOfFilesToConvertPretty}

    # Extract the file name from the in file path so we can generate the outfile path
    inFileName=$(basename ${inFilePath})

    # Generate the out file path, swapping the file extension
    outFilePath="out/${inFileName%.bwav}.wav"

    echo "├─[CONV] Converting '${inFilePath}' to '${outFilePath}'..."

    # Sanity check to stop us repeating ourselves, should add a -f command flag to allow overwrite or something
    if [ -f ${outFilePath} ]; then
        echo "└─[SKIP] Skipped conversion as '${outFilePath}' already exists."
        echo ""
        continue
    fi

    # Convert the file, supressing only stdout, we want stderr
    ./brstm_converter ${inFilePath} -o ${outFilePath} >/dev/null

    echo "└─[DONE] Conversion successful."
    echo ""
done

# Done
echo "Done."
