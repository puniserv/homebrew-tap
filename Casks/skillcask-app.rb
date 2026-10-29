cask "skillcask-app" do
  version "0.10.1"
  sha256 "630eaf1931d59287f46ccd25457a75290b20b1696bcffe3f9b4d01c62b0becd4"

  url "https://github.com/puniserv/skillcask/releases/download/v#{version}/Skillcask-#{version}-macos-universal.zip"
  name "Skillcask"
  desc "Desktop app for the skillcask package manager for agent skills"
  homepage "https://github.com/puniserv/skillcask"

  depends_on formula: "puniserv/tap/skillcask"
  depends_on macos: :sonoma

  app "Skillcask.app"

  zap trash: [
    "~/Library/Preferences/io.github.puniserv.skillcask.plist",
    "~/Library/Saved Application State/io.github.puniserv.skillcask.savedState",
  ]
end
