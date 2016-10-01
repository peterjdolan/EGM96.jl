# EGM96 in Julia

This is a direct port of the EGM96 model as defined by the NGIS.  More infomration can be
found at http://earth-info.nga.mil/GandG/wgs84/gravitymod/egm96/egm96.html.

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

To support development, it helps to add the parent of this directory (the one containing
the "EGM96" directory) to your .juliarc.jl, as such:

```
push!(LOAD_PATH, "/home/peter/workspace/anuncommonlab/a-few-spacecraft-utilities/julia")
```

More information on Julia module search paths can be found at http://docs.julialang.org/en/release-0.5/manual/modules/

## Problems

Currently, the Julia package makes two direct calls to a compiled shared C library, but it's
unclear how to make that shared library transparently available in a Julia package.  How does
one effectively compile and link it at runtime?

https://github.com/mlewe/BlossomV.jl/ and
https://github.com/JuliaLang/BinDeps.jl do this, and can be used as
examples.