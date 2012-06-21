CC=coffee
CONCAT=cat
MINIFIER=uglifyjs

append_extension = $1.$2

output_directory = $(CURDIR)/../tastybone/static/scripts
base_filename = $(output_directory)/tastybone

output_filename = $(call append_extension,$(base_filename),js)
output_filename_minified = $(call append_extension,$(base_filename),min.js)

objects = main.js

all: $(output_filename_minified)

$(output_filename_minified): $(output_filename)
	${MINIFIER} ${output_filename} > ${output_filename_minified}

$(output_filename): $(objects) $(output_directory)
	$(CONCAT) $(objects) > $(output_filename)

$(objects): %.js: %.coffee 
	coffee -c $<

$(output_directory):
	mkdir -p $@

clean:
	-rm -f $(output_filename) $(output_filename_minified)
	-rm -f $(objects)

.PHONY: all clean

