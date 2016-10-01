using BinDeps

# Find the directory with installed Julia libraries
julialibpath = dirname(Libdl.dlpath(Libdl.dlopen("libgmp")))

# Set link flags for Autotools external packages
# This is only needed for the ecm package
ENV["LDFLAGS"] = "-L$julialibpath"
# config.log shows that BinDeps also set the following as well.
# We have copied gmp.h from Julia source tree to this location.
# Maybe Julia should also copy it to the installation tree.
ENV["CPPFLAGS"] = "-I../../usr/include"

# -Wl... makes the libecm search for libgmp in the Julia installation rather than the system.
# (The  -lgmp should not be neccessary, but it is.
# The Makefile writes -lgmp multiple times in link commands. -lm occurs five times per link command.)
ENV["LIBS"] = "-lgmp -Wl,-rpath -Wl,$julialibpath"

@BinDeps.setup

libf477 = library_dependency("libf477")

# BinDeps.depsdir(libf477) is /pathto/PackageName/deps
const cpcsrcdir = joinpath(BinDeps.depsdir(libf477),"src","f477")
# This source for this library will not be downloaded; it is in this repo.
# BuildProcess and SimpleBuild may use the information in provides(Sources...
# Here, we need no such information, and so omit GetSources.
provides(SimpleBuild,
    (@build_steps begin
        ChangeDirectory(cpcsrcdir)
        `make`
        `make install`            
    end),libf477, os = :Unix)

@BinDeps.install Dict([(:libf477, :libf477)])
