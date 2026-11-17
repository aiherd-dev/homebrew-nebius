cask "aiherd" do
  native_arm = Hardware::CPU.physical_cpu_arm64?
  arch = native_arm ? "aarch64" : "x86_64"

  version "6.0.0"
  sha256 native_arm ? "c412fa88bfd393c1e6d0285705e8e92750d050bef3a516132b4780da38eb3527" : "74025c03a060c0dbd7a8fd0cd636085cdef76bab98fceb5ccbd7fb79e61a45ba"

  url "https://github.com/aiherd-dev/homebrew-nebius/releases/download/v#{version}/aiherd-#{version}-#{arch}-apple-darwin.zip"
  name "AIHerd"
  desc "Terminal dashboard with a pinned organization relay"
  homepage "https://github.com/aiherd-dev/homebrew-nebius"

  conflicts_with cask: "aiherd-dev/aiherd/aiherd"
  depends_on macos: :sonoma

  app "AIHerd.app"
  binary "#{appdir}/AIHerd.app/Contents/MacOS/aih"

  uninstall_preflight do
    system_command "#{appdir}/AIHerd.app/Contents/MacOS/aih",
                   args: ["uninstall-launchd"], must_succeed: false
  end

  postflight do
    system_command "#{appdir}/AIHerd.app/Contents/MacOS/aih",
                   args: ["install-launchd"], must_succeed: false
  end

  uninstall quit: ["dev.aiherd.AIHerd"]

  zap trash: [
    "~/Library/Application Support/aiherd",
    "~/Library/Logs/aiherd-serve.log",
  ]
end
