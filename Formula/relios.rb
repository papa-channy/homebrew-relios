class Relios < Formula
  desc "Local release pipeline CLI for SwiftPM macOS apps"
  homepage "https://github.com/papa-channy/relios"
  url "https://github.com/papa-channy/relios/archive/refs/tags/v0.0.999.tar.gz"
  sha256 "29354e4ea11a08e83c43b1f86941a91978cd816f1256a84d749a48947d5928a5"
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