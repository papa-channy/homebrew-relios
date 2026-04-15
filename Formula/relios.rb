class Relios < Formula
  desc "Local release pipeline CLI for SwiftPM macOS apps"
  homepage "https://github.com/papa-channy/relios"
  url "https://github.com/papa-channy/relios/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "d096cfed9f0e8e7fc67f3fca55e298b8cd9e7ae551ca247cd27703597cb41969"
  license "MIT"
  head "https://github.com/papa-channy/relios.git", branch: "main"

  depends_on xcode: ["15.0", :build]
  depends_on :macos

  def install
    # Bake the release tag into the CLI's --version output. Source checkouts
    # keep the sentinel; Homebrew installs pin to the Formula's version.
    inreplace "Sources/ReliosCLI/ReliosCommand.swift",
              /version: "[^"]+",/, "version: \"#{version}\","
    system "swift", "build", "--disable-sandbox", "-c", "release"
    bin.install ".build/release/relios"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/relios --version")
  end
end