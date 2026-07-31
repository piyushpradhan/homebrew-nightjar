cask "nightjar" do
  version "0.1.25"
  sha256 "4bdd52ecee559f21bf9bf4f2baed9058265fe902bfa646e09ccfb2d9d8c3fae8"

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
