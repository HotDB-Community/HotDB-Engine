#!/usr/bin/env bash
#
# Wrapper script for MySQL's build.

usage() {
cat <<EOF
Usage: `basename $0` [-b <boost_dir>] [-d <dest_dir>] [-t debug|release] [-B <build_dir>]
                     [-v 1|0] [-D 1|0|default] [-G 1|0]
                     [--asan | --msan | --tsan | --ubsan]
       or
       `basename $0` [-h | --help]

  -b                      Set the boost directory.

                          The option is like /usr/local/boost_1_70_0
                          instead of /usr/local/boost_1_70_0/include. 
                          Default: $boost_dir.

  -d                      Set the destination directory. Default: $dest_dir.

  -g                      Turn on unittest (gmock) compilation.

  -t                      Select the build type. Default: $build_type.
                          MySQL defines build type as: Debug, Release, 
                          RelWithDebInfo.  The mapping here is: 
                            debug => Debug
                            release => RelWithDebInfo

  -v                      With or without valgrind. Default: $valgrind.

  -D                      With or without debug [for debug sync etc]. 
                          Default: 1 for Debug, 0 for RelWithDebInfo.

  -G                      Whether generate cbase binary.

  --asan                  Turn on ASAN

  --msan                  Turn on MSAN

  --tsan                  Turn on TSAN

  --ubsan                 Turn on UBSAN

  -i                      Set git commit

  -h, --help              Show this help message.

Note: this script is intended for internal use by MySQL developers.
EOF
}

check_error() {
  if [ "$?" -ne 0 ]; then
    if [ x"$1" != x"" ]; then
      echo "ERROR: $1"
    fi
    exit 1 
  fi
}

get_option_value() {
  echo "$1" | sed 's/^-[a-zA-Z_-]*=//'
}

parse_options() {
  while test $# -gt 0; do
    case "$1" in
    -b=*)
      boost_dir=`get_option_value "$1"`
    ;;
    -b)
      shift
      boost_dir=`get_option_value "$1"`
    ;;
    -d=*)
      dest_dir=`get_option_value "$1"`
    ;;
    -d)
      shift
      dest_dir=`get_option_value "$1"`
    ;;
    -g)
      shift
      gmock_enable="1"
    ;;
    -t=*)
      build_type=`get_option_value "$1"`
    ;;
    -t)
      shift
      build_type=`get_option_value "$1"`
    ;;
    -v=*)
      valgrind=`get_option_value "$1"`
    ;;
    -v)
      shift
      valgrind=`get_option_value "$1"`
    ;;
    -D=*)
      debug=`get_option_value "$1"`
    ;;
    -D)
      shift
      debug=`get_option_value "$1"`
    ;;
    -G=*)
      generate_binary=`get_option_value "$1"`
    ;;
    -G)
      shift
      generate_binary=`get_option_value "$1"`
    ;;
    -B=*)
      build_dir=`get_option_value "$1"`
    ;;
    -B)
      shift
      build_dir=`get_option_value "$1"`
    ;;
    --asan)
      asan=1
    ;;
    --msan)
      msan=1
    ;;
    --tsan)
      tsan=1
    ;;
    --ubsan)
      ubsan=1
    ;;
    -i=*)
	  commit_input=`get_option_value "$1"`
    ;;
	  -i)
	  shift
	  commit_input=`get_option_value "$1"`
    ;;
    --clang)
      clang=1
    ;;
    -h | --help)
      usage
      exit 0
    ;;
    *)
      echo "Unknown option '$1'"
      exit 1
    ;;
    esac 
    shift 
  done
}

check_options() {
  if [ ! -d "$boost_dir" ]; then
    echo "Boost directory $boost_dir not exists or is not a directory."
    exit 1
  fi

  if [ x"$build_type" = x"debug" ]; then
    cmake_build_type="Debug"
  elif [ x"$build_type" = x"release" ]; then
    cmake_build_type="RelWithDebInfo"
  else
    echo "Invalid build type, it must be \"debug\" or \"release\" or \"none\"."
    exit 1
  fi

  if [ x"$valgrind" != x"1" -a x"$valgrind" != x"0" ]; then
    echo "Invalid valgrind value, it must be 1 or 0."
    exit 1
  fi

  if [ x"$debug" = x"default" ]; then
    if [ x"$cmake_build_type" = x"Debug" ]; then
      debug=1
    elif [ x"$cmake_build_type" = x"RelWithDebInfo" ]; then
      debug=0
    fi
  else
    if [ x"$debug" != x"1" -a x"$debug" != x"0" ]; then
      echo "Invalid debug value, it must be 1, 0, or default."
      exit 1
    fi
  fi

  if [ -f "$build_dir" ]; then
    echo "File '$build_dir' exists but it is not a directory."
    exit 1
  fi
}

dump_options() {
  echo "Dumping the options used by $0 ..."
  echo "build_type=$build_type"
  echo "boost_dir=$boost_dir"
  echo "dest_dir=$dest_dir"
  echo "build_dir=$build_dir"
  echo "valgrind=$valgrind"
  echo "debug=$debug"
  echo "asan=$asan"
  echo "msan=$msan"
  echo "tsan=$tsan"
  echo "ubsan=$ubsan"
  echo "gmock_zip=$gmock_zip"
}

pwd=`pwd`
build_type="debug"
dest_dir="/usr/local/cbase"
build_dir="bld-$build_type"
boost_dir="$pwd/"
tsmdir="$pwd/extra/TencentSM/TencentSM-1.7.3-2"
valgrind=0      # Default, turn-ed off
debug=default   # Default, which means value not set.
asan=0
msan=0
tsan=0
ubsan=0
gmock_zip=""
generate_binary="1"

parse_options "$@"

if [ "${gmock_enable}x" == "1x" ];then
  gmock_zip="$pwd/source_downloads/googletest-release-1.10.0.zip"
fi

check_options
dump_options

if [ ! -d "$build_dir" ]; then
  mkdir "$build_dir"
  check_error
else
  echo "Directory '$build_dir' exists, use it."
  # Remove the caches of cmake, to make sure it will generate files
  # into build directory.
  rm -f CMakeCache.txt
fi

if [ ! -n "$commit_input" ]; then
  git_log=`git log -1 |head -n 1| awk '{print $2}'`
else
  git_log=$commit_input
fi

if [ $clang -eq 1 ]; then
  echo "clang is ON"
  CC=clang
  CXX=clang++
  export CC CXX
fi

cd "$pwd/$build_dir"
check_error

echo "Start to run cmake at `pwd`..."

which cmake3
if [ "$?" -eq 0 ]
then
  cmk="cmake3"
else
  cmk="cmake"
fi


  # normal compile.
  $cmk .. \
    -DFORCE_INSOURCE_BUILD=1                    \
    -DCMAKE_BUILD_TYPE="$cmake_build_type"      \
    -DSYSCONFDIR="$dest_dir"                    \
    -DCMAKE_INSTALL_PREFIX="$dest_dir"          \
    -DMYSQL_DATADIR="$dest_dir/data"            \
    -DWITH_DEBUG=$debug                         \
    -DWITH_VALGRIND=$valgrind                   \
    -DENABLED_PROFILING=1                       \
    -DWITH_EXTRA_CHARSETS=all                   \
    -DWITH_CURL=system                          \
    -DWITH_ENTERPRISE_ENCRYPTION=1              \
    -DWITH_SSL_PATH=/usr/local/ssl              \
    -DWITH_ZLIB=bundled                         \
    -DWITH_BOOST="$boost_dir/boost/"            \
    -DWITH_INNOBASE_STORAGE_ENGINE=1            \
    -DWITH_ARCHIVE_STORAGE_ENGINE=0             \
    -DWITH_BLACKHOLE_STORAGE_ENGINE=0           \
    -DWITH_PERFSCHEMA_STORAGE_ENGINE=1          \
    -DENABLED_LOCAL_INFILE=1                    \
    -DWITH_FEDERATED_STORAGE_ENGINE=0           \
    -DWITH_EXAMPLE_STORAGE_ENGINE=0             \
    -DINSTALL_LAYOUT=STANDALONE                 \
    -DWITH_ASAN=$asan                           \
    -DWITH_MSAN=$msan                           \
    -DWITH_TSAN=$tsan                           \
    -DWITH_UBSAN=$ubsan                         \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON          \
    -DLOCAL_GMOCK_ZIP="${gmock_zip}"            \
    -DGIT_COMMIT="$git_log"                     \
    -DDOWNLOAD_BOOST=1

check_error
cd "$pwd"

if [ x"$generate_binary" = x"1" ]; then
  ncpus=`cat /proc/cpuinfo | grep -c '^processor'`
  unbuffer make VERBOSE=1 -C $build_dir -j$ncpus 2>&1 | tee build.log
  ## check if built successfully
  grep build.log -e "100%" > /dev/null
  check_error
fi

#end of file
