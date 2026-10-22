# Homebrew tap for DeepClean

```sh
brew install --cask bunthondev/tap/deepclean
```

Update with `brew upgrade --cask deepclean`. Remove with `brew uninstall --cask deepclean`
(`brew uninstall --cask --zap deepclean` also deletes its preferences).

DeepClean is not notarized by Apple. The cask clears the quarantine flag after install, so the
app opens without the "cannot be opened" dialog. Homebrew's old `--no-quarantine` flag was removed
in July 2026 and is no longer needed here.

Project: https://github.com/bunthondev/deep-clean
