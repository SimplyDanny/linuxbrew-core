class Libjwt < Formula
  desc "JSON Web Token C library"
  homepage "https://github.com/benmcollins/libjwt"
  url "https://github.com/benmcollins/libjwt/archive/v1.12.1.tar.gz"
  sha256 "d29e4250d437340b076350e910e69fd5539ef8b92528d0306745cec0e343cc17"
  license "MPL-2.0"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "c132de71b6eb84519d45486fc00a222336d9f4dfb2d02f9fa28a0a2f358897be"
    sha256 cellar: :any, big_sur:       "ec42c8a376a14d6c31b51674d7b93ec0a8413d5dc72c68e86165fbea23e0a3e5"
    sha256 cellar: :any, catalina:      "09d81d6913f1df2baac52ff074f626cbad08abfe1a8a0c8c1139b26e170dc850"
    sha256 cellar: :any, mojave:        "9e515914ebc32d9262f7d64ff59ed90fe0268d7068cf589d71abca2fed7d7df9"
    sha256 cellar: :any, high_sierra:   "6028bf4f5150f6051373a0317466f476ba6fcb5855f1db45627b9fcb079aeffd"
    sha256 cellar: :any, x86_64_linux:  "ebde644ce1bf30b70bd5509b38ae6d20e4f152067afa5e5447bb20f733b16117"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "jansson"
  depends_on "openssl@1.1"

  def install
    system "autoreconf", "-fiv"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "all"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdlib.h>
      #include <jwt.h>

      int main() {
        jwt_t *jwt = NULL;
        if (jwt_new(&jwt) != 0) return 1;
        return 0;
      }
    EOS
    system ENV.cc, "-L#{lib}", "-I#{include}", "test.c", "-ljwt", "-o", "test"
    system "./test"
  end
end
