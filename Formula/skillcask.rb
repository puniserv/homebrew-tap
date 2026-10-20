class Skillcask < Formula
  desc "A lockfile-first package manager for AI agent skills (SKILL.md), backed by Composer repositories"
  homepage "https://github.com/puniserv/skillcask"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/puniserv/skillcask/releases/download/v0.3.0/skillcask-aarch64-apple-darwin.tar.xz"
      sha256 "0dfe1f979ec694058d8abe9dde52a48ab70e9d253f9d522c1a76ab8a38329f9c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/puniserv/skillcask/releases/download/v0.3.0/skillcask-x86_64-apple-darwin.tar.xz"
      sha256 "33d756445d60cd8bd033a7f6fbf369fb4fc6a4e19140efe017a4b7c429859f01"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/puniserv/skillcask/releases/download/v0.3.0/skillcask-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d83756b63156b28616cec19e7b20bfde466729bfd307b52bb5cc12272c960aae"
    end
    if Hardware::CPU.intel?
      url "https://github.com/puniserv/skillcask/releases/download/v0.3.0/skillcask-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d7111f52e76be6006d1c326cbf0eeb7be6ba821bb0866abda05882862ca0b469"
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
