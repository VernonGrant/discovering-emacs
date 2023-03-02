.PHONY: serve build clean

serve:
	npx @marp-team/marp-cli@latest --theme-set ./youtube/css/theme.css -s ./youtube/

build:
	npx @marp-team/marp-cli@latest --allow-local-files --theme-set ./youtube/css/theme.css --images png --image-scale 3 ./youtube/episode-3.md

clean:
	rm ./youtube/episode-*.png
