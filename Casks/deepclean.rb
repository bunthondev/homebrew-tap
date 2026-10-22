cask "deepclean" do
  version "0.2.1"
  sha256 "c1887d00a0feb2db56e4e59fbbb423ae444d3bb08ec086a274f7686aa461f683"

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
