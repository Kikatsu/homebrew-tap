cask "pip-notch" do
  version "0.1.4"
  sha256 "ea11e8bba4ec6c088b6053cc8f444fb722d98ba97182c7e9434302463c78d91b"

  url "https://github.com/Kikatsu/pip-notch/releases/download/v#{version}/Pip-#{version}.zip"
  name "Pip"
  desc "Notch companion that shows what your AI coding agents are doing"
  homepage "https://github.com/Kikatsu/pip-notch"

  livecheck do
    url :url
    strategy :github_releases
  end

  depends_on macos: :sonoma

  app "Pip/Pip.app"

  # Pip isn't notarized yet, so macOS would refuse to open it. Clear the download
  # quarantine so it opens normally; this is what the manual install asks for too.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Pip.app"],
        writable_paths: ["Pip.app"],
        writable_base:  :appdir
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
