#!/bin/sh
# Run this to generate all the initial makefiles, etc.

test -n "$srcdir" || srcdir=`dirname "$0"`
test -n "$srcdir" || srcdir=.

olddir=`pwd`
cd $srcdir

echo -n "checking for pkg-config... "
which pkg-config || {
	echo "*** No pkg-config found, please install it ***"
	exit 1
}

echo -n "checking for autoreconf... "
which autoreconf || {
	echo "*** No autoreconf found, please install it ***"
	exit 1
}

touch ChangeLog

echo "running autoreconf --force --install --verbose"
autoreconf --force --install --verbose || exit $?

cd $olddir
echo "running configure $@"
test -n "$NOCONFIGURE" || "$srcdir/configure" "$@"
