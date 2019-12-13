class Fribidi < Formula
  desc "Implementation of the Unicode BiDi algorithm"
  homepage "https://github.com/fribidi/fribidi"
  url "https://github.com/fribidi/fribidi/releases/download/v1.0.8/fribidi-1.0.8.tar.bz2"
  sha256 "94c7b68d86ad2a9613b4dcffe7bbeb03523d63b5b37918bdf2e4ef34195c1e6c"

  bottle do
    cellar :any
    sha256 "7c58375946f07539963d47d9a0bd62cdea933f7812e1ff6fa4da38a616870241" => :catalina
    sha256 "90c16d9107c1d6819d94a9b815ab492b11bcd91e1cf2b2b0bd397632665741fc" => :mojave
    sha256 "37d4cd085160929b946823d08698ac39006788de5c1e3c993f043eb70c4af96d" => :high_sierra
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--enable-static"
    system "make", "install"
  end

  test do
    (testpath/"test.input").write <<~EOS
      a _lsimple _RteST_o th_oat
    EOS

    assert_match /a simple TSet that/, shell_output("#{bin}/fribidi --charset=CapRTL --test test.input")
  end
end
