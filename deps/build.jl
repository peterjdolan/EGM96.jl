using BinDeps

@BinDeps.setup

libf477 = library_dependency("libf477")

const cpcsrcdir = joinpath(BinDeps.depsdir(libf477),"src","f477")
provides(SimpleBuild,
    (@build_steps begin
        ChangeDirectory(cpcsrcdir)
        `make`
        `make install`            
    end),libf477, os = :Unix)

@BinDeps.install Dict([(:libf477, :libf477)])
