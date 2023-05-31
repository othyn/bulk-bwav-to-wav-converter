#!/usr/bin/env bash

# This script is designed to run from the makefile in the root of the project, and thus all paths will be anchored to
# the root of the project, not src. For that reason, there is no anchoring of the directory paths to the script
# directory using something like:
# scriptDir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Check if the required tools are installed
if ! command -v ffprobe >/dev/null 2>&1; then
    echo "Please install ffmpeg first."
    echo "On macOS, this can be done via: $ brew install ffmpeg"
    exit 1
fi

# Gather a list of files to organise, avoiding argument expansion faults with large amounts of files
filesToOrganise=(`find out -maxdepth 1 -name "*.wav"`)

# Get the amount of items in the array for sanity checking and helpful command progress output
amountOfFilesToOrganise=${#filesToOrganise[@]}

# Locale format the command output total amount of files number
amountOfFilesToOrganisePretty=$(printf "%'.0f" ${amountOfFilesToOrganise})

# Check if there is anything to organise
if [ ${amountOfFilesToOrganise} -eq 0 ]; then
    echo "Nothing to organise. Please run the conversion first!"
    exit 0
fi

# Setup a file index ticker, the alternative is to loop the keys in the array with ${!filesToOrganise[@]} and instead
# call array elements when required with the index ${filesToOrganise[$i]}. But a ticker seems cleaner...
currentFileIdx=0

# Convert shit
for outFilePath in ${filesToOrganise[@]}; do
    # Increment the ticker
    ((currentFileIdx++))

    # Locale format the command output current file number
    currentFileIdxPretty=$(printf "%'.0f" ${currentFileIdx})

    # Using the current length of the finishing number, output and pad the current progress
    printf "┌[PROG] %${#amountOfFilesToOrganisePretty}s / %s\n" ${currentFileIdxPretty} ${amountOfFilesToOrganisePretty}

    # Extract the file name from the in file path so we can generate the outfile path
    outFileName=$(basename ${outFilePath})

    # Find out the duration of the file
    # https://stackoverflow.com/a/59140645/4494375
    durationInSeconds=$(ffprobe -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "${outFilePath}" 2>/dev/null)
    durationInSeconds=$(printf "%'.2f" ${durationInSeconds})
    durationInSecondsInt=$(printf "%'.0f" ${durationInSeconds})

    echo "├[FILE] ${outFileName}"
    echo "├[DURA] ${durationInSeconds} seconds"

    if [ "${durationInSecondsInt}" -le 5 ]; then
        durationDirName="Less than 5 seconds"
    elif [ "${durationInSecondsInt}" -le 15 ]; then
        durationDirName="Less than 15 seconds"
    elif [ "${durationInSecondsInt}" -le 30 ]; then
        durationDirName="Less than 30 seconds"
    else
        durationDirName="Greater than 30 seconds"
    fi

    organisedDir="out/${durationDirName}"
    organisedPath="${organisedDir}/${outFileName}"

    if [ ! -d "${organisedDir}" ]; then
        mkdir "${organisedDir}"
    fi

    if [ ! -f "${organisedPath}" ]; then
        mv "${outFilePath}" "${organisedPath}"
    else
        echo "└[SKIP] Skipped organisation as '${organisedPath}' already exists."
        echo ""
        continue
    fi

    echo "├[ORGN] Determination: ${durationDirName}"
    echo "├[ORGN] Moved '${outFilePath}' to '${organisedPath}'"
    echo "└[DONE] Organised."
    echo ""
done

# Done
echo "Done."
