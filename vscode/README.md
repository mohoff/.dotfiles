# Visual Studio Code (VSC) config

List all installed extensions:

```sh
code --list-extensions
```

Install extensions listed in `extensions.txt`:

```sh
code --list-extensions | xargs -L 1 code --install-extension
```
