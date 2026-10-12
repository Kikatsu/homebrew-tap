cask "pip-notch" do
  version "0.1.2"
  sha256 "49c5973aea5c07ae7fe1d0236cf2db72eaa65eea15bda690cd808a263c347d1c"

  url "https://github.com/Kikatsu/pip-notch/releases/download/v#{version}/Pip-#{version}.zip"
  name "Pip"
  desc "Notch companion that shows what your AI coding agents are doing"
  homepage "https://github.com/Kikatsu/pip-notch"

  livecheck do
    url :url
    strategy :github_releases
  end

  depends_on macos: ">= :sonoma"

  app "Pip/Pip.app"

  # Pip isn't notarized yet, so macOS would refuse to open it. Clear the download
  # quarantine so it opens normally; this is what the manual install asks for too.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Pip.app"]
  end

  uninstall quit: "com.kikatsu.pip"

  zap trash: [
    "~/Library/Application Support/Pip",
    "~/Library/Preferences/com.kikatsu.pip.plist",
  ]

  caveats <<~EOS
    Pip adds hooks to your AI agents' config files. Before uninstalling, open
    Pip Settings → Agents and click Disconnect for each agent, so they stop
    calling Pip's helper.
  EOS
end
