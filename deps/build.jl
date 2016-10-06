using BinDeps

@BinDeps.setup

libf477 = library_dependency("libf477")

const cpcsrcdir = joinpath(BinDeps.depsdir(libf477),"src","f477")
provides(SimpleBuild,
    (@build_steps begin
        ChangeDirectory(cpcsrcdir)
        `make install`            
    end), libf477)

@BinDeps.install Dict([(:libf477, :libf477)])
