cask "deepclean" do
  version "0.1.1"
  sha256 "a1d4e971b2562593983301dcf1f27866e438b5906a9a05aba9cec60f7cbe2acb"

  url "https://github.com/bunthondev/deep-clean/releases/download/v#{version}/DeepClean-#{version}.zip"
  name "DeepClean"
  desc "Finds developer caches and build folders on your Mac, explains them, trashes only what you confirm"
  homepage "https://bunthondev.github.io/deep-clean/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: ">= :sonoma"

  app "DeepClean.app"

  zap trash: [
    "~/Library/Preferences/com.devkh.deepclean.plist",
    "~/Library/Saved Application State/com.devkh.deepclean.savedState",
  ]

  caveats <<~EOS
    DeepClean is not notarized by Apple, so macOS blocks the first launch.
    Either reinstall with `brew install --cask --no-quarantine bunthondev/tap/deepclean`
    or run once:
      xattr -d com.apple.quarantine "#{appdir}/DeepClean.app"
  EOS
end
