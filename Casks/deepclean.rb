cask "deepclean" do
  version "0.2.6"
  sha256 "723301fb414df4d7d4a99bf1c918dbf909cb9939621724e0c04718c6300ab6c9"

  url "https://github.com/bunthondev/deep-clean/releases/download/v#{version}/DeepClean-#{version}.zip"
  name "DeepClean"
  desc "Finds developer caches and build folders on your Mac, explains them, trashes only what you confirm"
  homepage "https://bunthondev.github.io/deep-clean/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "DeepClean.app"

  # The build is not notarized by Apple. Clearing the quarantine flag here lets the app open
  # right after install instead of being blocked by Gatekeeper.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/DeepClean.app"],
                   must_succeed: false
  end

  zap trash: [
    "~/Library/Preferences/com.devkh.deepclean.plist",
    "~/Library/Saved Application State/com.devkh.deepclean.savedState",
  ]

  caveats <<~EOS
    DeepClean is not notarized by Apple. This cask clears the quarantine flag after
    install so the app opens normally. If macOS still blocks it, run once:
      xattr -dr com.apple.quarantine "#{appdir}/DeepClean.app"
  EOS
end
