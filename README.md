# EGM96 in Julia

This is a direct port of the EGM96 model as defined by the NGIS.  More information can be
found at http://earth-info.nga.mil/GandG/wgs84/gravitymod/egm96/egm96.html.

[![Mac + Linux Build Status](https://travis-ci.org/peterjdolan/EGM96.jl.svg?branch=master)](https://travis-ci.org/peterjdolan/EGM96.jl)
[![Windows Build status](https://ci.appveyor.com/api/projects/status/khbxit8u1kva9qsk?svg=true)](https://ci.appveyor.com/project/peterjdolan/egm96-jl)
[![codecov](https://codecov.io/gh/peterjdolan/EGM96.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/peterjdolan/EGM96.jl)

[![EGM96](http://pkg.julialang.org/badges/EGM96_0.5.svg)](http://pkg.julialang.org/?pkg=EGM96) 
[![EGM96](http://pkg.julialang.org/badges/EGM96_0.6.svg)](http://pkg.julialang.org/?pkg=EGM96)

## Licensing

EGM96.jl wraps a C-translation of a Fortran program that was provided by the U.S.
government, implementing the EGM96 data model, which was produced and published by
the U.S. government. The relevant licenses are as follows:

 * EGM96 model: [U.S. Public Domain](https://project-open-data.cio.gov/open-licenses/)
 * EGM96 C-translation: [ZLib license](http://zlib.net/zlib_license.html)
 * EGM96.jl Julia wrapper: [MIT license](https://opensource.org/licenses/MIT)

## Implementation

This Julia module depends directly and indirectly on the base Fortran implementation of
EGM96 as provided by the NGIS.  A Fortran implementation of EGM96 was provided at
http://earth-info.nga.mil/GandG/wgs84/gravitymod/egm96/egm96.html

This implementation depends on an automatic translation of that Fortran code to C, which was
downloaded from https://sourceforge.net/projects/egm96-f477-c/ on September 29, 2016.

This automatic translation was modified only by removing the main method, which was then
reimplemented in Julia so that the functionality can be made available programmatically
(the library as originally implemented depended on an INPUT file being provided, the binary
executed, and a resulting OUTPUT file being then consumed).

## Development

Because this library depends on a C library, testing relies on having built and installed
the shared object.  After that is done, testing of the Julia code can be done more
directly.

First, install the package locally.  This will only install the latest code that's committed
to your local git repository, and will not pick up any uncommitted changes.
```
git commit -a -m "working"
make clean install
```

Then, testing can be done easily (and using uncommitted changes to the Julia code) with:
```
julia test/runtests.jl
```
