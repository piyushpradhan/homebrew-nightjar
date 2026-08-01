cask "nightjar" do
  version "0.1.27"
  sha256 "b51c1232b246156896d923147f1be39cf1e4e2d6572a895703768c4ad5af0402"

  url "https://github.com/piyushpradhan/homebrew-nightjar/releases/download/v#{version}/Nightjar_#{version}_arm64.dmg",
      verified: "github.com/piyushpradhan/homebrew-nightjar/"
  name "Nightjar"
  desc "Local, observable cron/scheduled-job manager — cron with eyes"
  homepage "https://nightjar.pro"

  livecheck do
    url "https://github.com/piyushpradhan/homebrew-nightjar/releases/latest"
    strategy :github_latest
  end

  auto_updates false
  depends_on macos: :big_sur
  depends_on arch: :arm64

  app "Nightjar.app"

  # No Apple Developer ID. Strip the download quarantine, then re-apply
  # a sealed ad-hoc signature so Gatekeeper accepts the app.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/Nightjar.app"]
    system_command "/usr/bin/codesign",
                   args: ["--force", "--deep", "--sign", "-", "#{appdir}/Nightjar.app"]
  end

  zap trash: [
    "~/Library/Application Support/Nightjar",
    "~/Library/Caches/com.piyushpradhan.nightjar",
    "~/Library/Preferences/com.piyushpradhan.nightjar.plist",
    "~/Library/Saved Application State/com.piyushpradhan.nightjar.savedState",
  ]
end
