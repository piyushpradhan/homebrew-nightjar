cask "nightjar" do
  version "0.1.21"
  sha256 "ea65f6fa994d8514c2e496be16dff7d837c0b96b562cb5dbde4525838bb59bc5"

  url "https://github.com/piyushpradhan/nightjar/releases/download/v#{version}/Nightjar_#{version}_arm64.dmg",
      verified: "github.com/piyushpradhan/nightjar/"
  name "Nightjar"
  desc "Local, observable cron and scheduled-job manager"
  homepage "https://nightjar.pro/"

  livecheck do
    url "https://github.com/piyushpradhan/nightjar/releases/latest"
    strategy :github_latest
  end

  auto_updates false
  depends_on macos: :big_sur
  depends_on arch: :arm64

  app "Nightjar.app"

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
