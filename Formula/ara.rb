class Ara < Formula
  desc "Command-line runtime for the ARA viewer: validate and serve Agent-Native Research Artifacts. Installs the `ara` binary."
  homepage "https://github.com/ARA-Labs/ara-cli"
  version "0.1.12"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ARA-Labs/ara-cli/releases/download/v0.1.12/ara-cli-aarch64-apple-darwin.tar.xz"
      sha256 "5d2ee65ec865ae29d1c0a78bb023c21ade17e2137cdf00afabf7a5b9f21c056a"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/ARA-Labs/ara-cli/releases/download/v0.1.12/ara-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "60b11e013c181ebb6a2a294092f733112745ae8c5d9d7b50b90b2db75ba5e8de"
    end
  end
  license "MPL-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "x86_64-unknown-linux-gnu": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "ara"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "ara"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
