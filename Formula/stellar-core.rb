class StellarCore < Formula
  desc "Backbone of the Stellar (XLM) network"
  homepage "https://www.stellar.org/"
  url "https://github.com/stellar/stellar-core.git",
      tag:      "v15.4.0",
      revision: "ff56e7f207b918aae53710abcc001511ead7ece9"
  license "Apache-2.0"
  head "https://github.com/stellar/stellar-core.git"

  bottle do
    sha256 cellar: :any, big_sur:  "271cde38b1e351d3840ad6e40e7c3967aba7f6d02eedeabf53d6e2b91ed927b6"
    sha256 cellar: :any, catalina: "3fe0e2a91e4dcf5c9e3f85bbad7710dda1222f9661aa9b5bc9715a66c39902a4"
    sha256 cellar: :any, mojave:   "cadc49de95a5acbef95cdfb14e98e005412fd9572f640e72a2f7dc64de156d52"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pandoc" => :build
  depends_on "pkg-config" => :build
  depends_on "parallel" => :test
  depends_on "libpq"
  depends_on "libpqxx"
  depends_on "libsodium"
  unless OS.mac?
    # Needs libraries at runtime:
    # /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version `GLIBCXX_3.4.22' not found
    depends_on "gcc@6"
    fails_with gcc: "5"
  end

  uses_from_macos "bison" => :build
  uses_from_macos "flex" => :build

  def install
    system "./autogen.sh"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--enable-postgres"
    system "make", "install"
  end

  test do
    system "#{bin}/stellar-core", "test",
      "'[bucket],[crypto],[herder],[upgrades],[accountsubentriescount]," \
      "[bucketlistconsistent],[cacheisconsistent],[fs]'"
  end
end
