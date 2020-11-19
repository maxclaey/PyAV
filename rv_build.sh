#!/bin/sh

# This build script is based on .github/workflows/tests.yml
# and can be used to build outside of CI (Linux only)

# Check if cibuildwheel is installed
if [ -z `which cibuildwheel` ]; then
    echo "[ERROR] Could not find cibuildwheel. Please install it via 'pip install cibuildwheel'"
    exit 1
fi

# =====================
# Create a source build
# =====================
pip install cython
python scripts/fetch-vendor /tmp/vendor
PKG_CONFIG_PATH=/tmp/vendor/lib/pkgconfig make build
python setup.py sdist

# ===================
# Create wheel builds
# ===================
# Set some environment variables from tests.yml, needed for Linux builds
export CIBW_BEFORE_BUILD="pip install cython && python scripts/fetch-vendor /tmp/vendor"
export CIBW_ENVIRONMENT_LINUX="LD_LIBRARY_PATH=/tmp/vendor/lib:/usr/local/lib:$LD_LIBRARY_PATH PKG_CONFIG_PATH=/tmp/vendor/lib/pkgconfig"
export CIBW_SKIP="cp27-* pp27-* pp36-win*"
export CIBW_TEST_COMMAND="mv {project}/av {project}/av.disabled && python -m unittest discover -t {project} -s tests && mv {project}/av.disabled {project}/av"
export CIBW_TEST_REQUIRES="numpy"

# Build with cibuildwheel
cibuildwheel --output-dir dist --platform linux
