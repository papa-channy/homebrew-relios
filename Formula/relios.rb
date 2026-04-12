class Relios < Formula
  desc "Local release pipeline CLI for SwiftPM macOS apps"
  homepage "https://github.com/papa-channy/relios"
  url "https://github.com/papa-channy/relios/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "a33fd107aa5f7ebf71567ff79d4f9ce9e369d49493bcb890b20fa5e6d4259b74"
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