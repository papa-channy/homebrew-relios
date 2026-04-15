class Relios < Formula
  desc "Local release pipeline CLI for SwiftPM macOS apps"
  homepage "https://github.com/papa-channy/relios"
  url "https://github.com/papa-channy/relios/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "608a130e00a67f27af2e5bf09eeb10270c8d8612ca0bd04ce257215eead4e9d3"
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