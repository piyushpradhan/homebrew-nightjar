cask "nightjar" do
  version "0.1.28"
  sha256 "5d76764ed78b539b53c5d30db346f5a8789583dea4c4fd77348fac592b7e4298"

  url "https://github.com/piyushpradhan/homebrew-nightjar/releases/download/v#{version}/Nightjar_#{version}_arm64.dmg",
      verified: "github.com/piyushpradhan/homebrew-nightjar/"
  name "Nightjar"
  desc "Local, observable cron/scheduled-job manager — cron with eyes"
  homepage "https://nightjar.pro"

  livecheck do
    url "https://github.com/piyushpradhan/homebrew-nightjar/releases/latest"
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :big_sur
  depends_on arch: :arm64

  app "Nightjar.app"

  # Keep Squirrel.Mac's designated requirement stable across builds,
  # while retaining Yank's no-Developer-ID distribution model.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/Nightjar.app"]
    system_command "/usr/bin/codesign",
                   args: ["--force", "--deep", "--sign", "-", "#{appdir}/Nightjar.app"]
    system_command "/usr/bin/codesign",
                   args: ["--force", "--sign", "-", "--requirements",
                          '=designated => identifier "com.piyushpradhan.nightjar"',
                          "#{appdir}/Nightjar.app"]
  end

  zap trash: [
    "~/Library/Application Support/Nightjar",
    "~/Library/Caches/com.piyushpradhan.nightjar",
    "~/Library/Preferences/com.piyushpradhan.nightjar.plist",
    "~/Library/Saved Application State/com.piyushpradhan.nightjar.savedState",
  ]
end
