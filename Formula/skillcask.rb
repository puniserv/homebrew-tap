class Skillcask < Formula
  desc "A lockfile-first package manager for AI agent skills (SKILL.md), backed by Composer repositories"
  homepage "https://github.com/puniserv/skillcask"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/puniserv/skillcask/releases/download/v0.5.0/skillcask-aarch64-apple-darwin.tar.xz"
      sha256 "20022aae69db2b49e0875b890b6e6f718e5c5eca930686eb5e0a1bbcce9f1b0b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/puniserv/skillcask/releases/download/v0.5.0/skillcask-x86_64-apple-darwin.tar.xz"
      sha256 "33b312e8d850f2ec229c3f6919596cf2515142caf48e8595b6a9cd137c1f5521"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/puniserv/skillcask/releases/download/v0.5.0/skillcask-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b5e11741166dbdc0b27c71d8108457c86bfccd55fdd4a0366e1aa93d27db0c89"
    end
    if Hardware::CPU.intel?
      url "https://github.com/puniserv/skillcask/releases/download/v0.5.0/skillcask-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7c30a6a154ef27b1c48d01ba901f05039af78cd7e6a3b5ac494e3806e5ddd82a"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

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
      bin.install "skillcask"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "skillcask"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "skillcask"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "skillcask"
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
