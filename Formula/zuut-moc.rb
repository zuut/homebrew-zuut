class ZuutMoc < Formula
  desc "The markedup object code generator"
  homepage "https://www.github.com/zuut/moc"
  url "https://github.com/zuut/moc/archive/refs/tags/0.9.401.tar.gz"
  sha256 "1fcfab08f6656d28f0b77dfa52359229df9890ac1423541b06bd4a7e97407b44"
  license "Apache-2.0"

  depends_on "cmake" => :build

  uses_from_macos "bison" => :build
  uses_from_macos "flex" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    bin.install_symlink "#{bin}/moc" => "zuutmoc"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test moc`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "#{bin}/moc --version"
  end

  def caveats
    <<-EOS
    To avoid conflicts, zuut-moc places the executable zuutmoc in
    homebrew's bin folder. If you wish to use the name moc, you
    need to add the installation directory to your path.

    To add moc's installation directory to your path, you can add
    the line below to your shell's config. E.g for bash, you can
    add the below to .bash_profile or .bashrc:

        PATH="$(brew --prefix zuut-moc)/bin:$PATH"

    EOS
  end
end
