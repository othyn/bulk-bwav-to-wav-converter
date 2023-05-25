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

### Quick guide for audio/sound/music asset backups from NSP's

This is purely for backup purposes and should only be done using legal cartridges you own.

1. Make sure Yuzu is setup and installed on your machine.
   - This is by far the easiest method, after I went down many ancient forum posts and archived GitHub repos trying to chase down an up to date resource.
   - Finally ended up seeing a YouTube video just saying 'use Yuzu'. Sure enough, its a right click option in Yuzu...
2. From within Yuzu, right click the game (that you've legally backed up from your cartridge and imported into Yuzu) you wish to backup the audio/sound/music assets for and click 'Dump RomFS' > 'Dump RomFS'.
3. On the popup window, select 'Full'.
   - Selecting 'Skeleton' will simply dump the folder structure only, which is useful for quickly seeing if there is a directory you like the look of.
   - There is no option to customise the dump location, it will dump into a dumps folder in the Yuzu application directory and it will automatically open it when its complete.
4. It will take a little while to dump.
   - For reference;
     - A 5900X with NVMe storage, it took about 5 minutes.
     - It was a similar time on my M1 Pro machine.
5. Once complete, it will open the dumped NSP RomFS contents location with your OS's file explorer.
   - This is placed into a dumps directory parented by the game ID within the Yuzu application directories.
   - From here you can then navigate and find any audio/sound/music assets you wish to backup.
