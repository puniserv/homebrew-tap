class Skillcask < Formula
  desc "A lockfile-first package manager for AI agent skills (SKILL.md), backed by Composer repositories"
  homepage "https://github.com/puniserv/skillcask"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/puniserv/skillcask/releases/download/v0.4.0/skillcask-aarch64-apple-darwin.tar.xz"
      sha256 "59e770a2e3b43d6934b04c98a6c3025a4a647f664cb1f549f195b7c62d807d56"
    end
    if Hardware::CPU.intel?
      url "https://github.com/puniserv/skillcask/releases/download/v0.4.0/skillcask-x86_64-apple-darwin.tar.xz"
      sha256 "c37a5d5aaf16f645803aa800da9adde11c745d5d7f7bd8011a258c4451eb9dd1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/puniserv/skillcask/releases/download/v0.4.0/skillcask-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7458ba5312d81f52967d1d033d493a274573181ddea28ac3ea3820ab1c817142"
    end
    if Hardware::CPU.intel?
      url "https://github.com/puniserv/skillcask/releases/download/v0.4.0/skillcask-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e0738500ced6d059d63c94bfb513948e7985f54c31dcdf9d93514a48b4a1dcc8"
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
