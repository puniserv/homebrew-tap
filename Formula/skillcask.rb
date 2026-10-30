class Skillcask < Formula
  desc "A lockfile-first package manager for AI agent skills (SKILL.md), backed by Composer repositories"
  homepage "https://github.com/puniserv/skillcask"
  version "0.10.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/puniserv/skillcask/releases/download/v0.10.2/skillcask-aarch64-apple-darwin.tar.xz"
      sha256 "cf0014fdd43023e8f018310c67e0c1e62d3cffdcc7a86c3828fc03c513a8e9bc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/puniserv/skillcask/releases/download/v0.10.2/skillcask-x86_64-apple-darwin.tar.xz"
      sha256 "15402bf5b9705cd76b2a7645f3ce2b58b2a912113ff2fb7b8a96952f1d602f7a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/puniserv/skillcask/releases/download/v0.10.2/skillcask-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5abf7b04bb9be095cdab57d5126165ca58a4dcedcd11e032a97ab374e78e9e98"
    end
    if Hardware::CPU.intel?
      url "https://github.com/puniserv/skillcask/releases/download/v0.10.2/skillcask-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1b280216318873b0408a82abf9da993652612605292f2cf27f254e76487db12a"
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
