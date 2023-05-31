.PHONY: setup
setup:
	@ echo "Building brstm_converter from source..."
	@ ( test -f brstm_converter && echo "> brstm_converter already compiled." ) || ( g++ -O2 -std=c++0x openrevolution/src/converter.cpp -o brstm_converter -w -Wall && echo "> brstm_converter compiled!" )
	@ printf "\n"

	@ echo "Done."

.PHONY: reset
reset:
	@ echo "Deleting brstm_converter built binary..."
	@ ( test -f brstm_converter && rm -rf brstm_converter && echo "> brstm_converter deleted." ) || echo "> brstm_converter already deleted."
	@ printf "\n"

	@ echo "Done."

.PHONY: convert
convert:
	@ echo "Converting..."
	@ src/convert.sh

.PHONY: organise
organise:
	@ echo "Organising..."
	@ src/organise.sh
