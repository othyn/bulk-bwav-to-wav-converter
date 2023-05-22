# Bulk BWAV to WAV Converter

A project that aims to convert BWAV (binary wave audio) files, specifically in the Nintendo format, to WAV (wave audio) files in a bulk/batch procedure.

My simple addition to this is just a wrapper script around the absolutely brilliant [ic-scm/openrevolution](https://github.com/ic-scm/openrevolution) project (which aims to provide a handy tool to convert video game audio to playable formats), in which itself implements the amazing work of [Gota7](https://github.com/Gota7) and their exploration and subsequent brain-dump of the [Nintendo Binary Wave Audio format](https://gota7.github.io/Citric-Composer/specs/binaryWav.html).

There is nothing smart going on in this repo, if anything its saving you a few minutes writing a for loop in bash.

## Requirements

There shouldn't be any, beyond having the `g++` build tool installed and exposed on your `PATH`, as required by [ic-scm/openrevolution](https://github.com/ic-scm/openrevolution) to build the `brstm_converter` binary that this project uses.

**Make sure when you clone the repo to do so _with_ sub modules**, otherwise this project will not work. This as this project will build the required underlying `brstm_converter` binary from the [ic-scm/openrevolution](https://github.com/ic-scm/openrevolution) repo.

## Setup

**Make sure when you clone the repo to do so _with_ sub modules**, otherwise none of the below will work. This as this project will build the required underlying `brstm_converter` binary from the [ic-scm/openrevolution](https://github.com/ic-scm/openrevolution) repo.

There is a `makefile` at the root of this project which aims to cover most of the project orchestration for you.

Firstly, we need to build that `brstm_converter` binary and get the project set up:

```sh
make setup
```

If you for whatever reason need to reset the repo, which reverts anything the `make setup` did above:

```sh
make reset
```

## Usage

1. Place any `*.bwav` files that you have in the `in` directory at the root of the project.
2. Run `make convert`.
3. Depending on how many files you have, this could be over in an instant or take several minutes, so find something to pass the time.
4. All converted `*.wav` files will be output to the `out` directory with the same file name as the source `*.bwav` file, just with the `*.wav` extension instead.
