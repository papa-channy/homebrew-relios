class Relios < Formula
  desc "Local release pipeline CLI for SwiftPM macOS apps"
  homepage "https://github.com/papa-channy/relios"
  url "https://github.com/papa-channy/relios/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "8301b71ff47c49c2b0d13e7d83357563c389e9cad696f5605ec08d4f06017893"
  license "MIT"
  head "https://github.com/papa-channy/relios.git", branch: "main"

  depends_on xcode: ["15.0", :build]
  depends_on :macos

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release"
    bin.install ".build/release/relios"
  end

  test do
    assert_match "relios", shell_output("#{bin}/relios --help")
  end
end