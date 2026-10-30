cask "skillcask-app" do
  version "0.10.2"
  sha256 "7e66618f2890b675e13afb52b6fdf1e905e2b23d964c267c3481eed5803e1af0"

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
