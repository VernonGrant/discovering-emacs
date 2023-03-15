.PHONY: serve build clean build-promo

serve:
	npx @marp-team/marp-cli@latest --theme-set ./youtube/css/theme.css -s ./youtube/

build:
	npx @marp-team/marp-cli@latest --allow-local-files --theme-set ./youtube/css/theme.css --images png --image-scale 3 ./youtube/episode-4.md

build-promo:
	npx @marp-team/marp-cli@latest --allow-local-files --theme-set ./youtube/css/theme.css --images png --image-scale 3 ./youtube/promo.md

clean:
	rm ./youtube/episode-*.png
