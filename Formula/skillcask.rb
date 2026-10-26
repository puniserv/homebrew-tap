class Skillcask < Formula
  desc "A lockfile-first package manager for AI agent skills (SKILL.md), backed by Composer repositories"
  homepage "https://github.com/puniserv/skillcask"
  version "0.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/puniserv/skillcask/releases/download/v0.8.0/skillcask-aarch64-apple-darwin.tar.xz"
      sha256 "bbda3688d128c0e68d0d3157dc05df59f387424cb12b9eb94e950d8f710f7831"
    end
    if Hardware::CPU.intel?
      url "https://github.com/puniserv/skillcask/releases/download/v0.8.0/skillcask-x86_64-apple-darwin.tar.xz"
      sha256 "a746ea391f4877c90ba1fc5e70c95206b93cfdb30317863b4b99bdbe82fb33f6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/puniserv/skillcask/releases/download/v0.8.0/skillcask-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fbeaac933ce91116ef3fd8d71448fc29a072b0a1c9f6c335efab35f57eeba98c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/puniserv/skillcask/releases/download/v0.8.0/skillcask-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "30827e311d06e39982b20c032cc61844d88206a29241b309a41d9e190a151077"
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
