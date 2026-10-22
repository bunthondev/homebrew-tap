cask "deepclean" do
  version "0.2.4"
  sha256 "b95995fa0e556cdf34c6c963df2ce06c11f4d2e3d7493e7b6bbb1122f00b87fd"

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
