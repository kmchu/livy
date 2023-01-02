# Livy
Livy was a famous Roman historian who wrote a monumental history of Rome, titled "From the Founding of the City". It is also the name of this Markdown to HTML implementation, built on top of Pandoc.

# Usage
```bash
# Checkout this repository
git clone git@github.com:kmchu/livy.git

# Create a symlink to the `livy.sh` in your local bin directory
ln -s ~/livy/livy.sh ~/.local/bin/livy
chmod a+x ~/.local/bin/livy

# Add local bin directory to your PATH (might want to add this to .bashrc also)
export PATH="$HOME/.local/bin:$PATH"
```

You could also create a custom `Makefile`:
```Makefile
.PHONY: all clean

all:
	- livy ./ output/

clean:
	- rm -rf output/*
```

# Resources
- [pandoc-markdown-css-theme](https://github.com/jez/pandoc-markdown-css-theme)
- [Panam styling](https://benjam.info/panam/)
- [bake: static site generation via Makefile](https://github.com/fcanas/bake)
