class Lara < Formula
  desc "Checker for the arguments behind research claims"
  homepage "https://github.com/ARA-Labs/Lara"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/ARA-Labs/Lara/releases/download/v0.3.8/lara-aarch64-apple-darwin.tar.xz"
      sha256 "5557a22f04580fdd3ce22ff3983c2bc0d9dd1a7be960d818f10713bee4a62ba2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ARA-Labs/Lara/releases/download/v0.3.8/lara-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6ed85dc46ec4f4630fd3be73e8e1d59ca246818359f7b1053f8317353cc673da"
    end
  end

  def install
    bin.install "lara"
    pkgshare.install "examples"
  end

  test do
    cp_r pkgshare/"examples/E1/.", testpath
    assert_match "accept", shell_output("#{bin}/lara check example.lara")
  end
end
