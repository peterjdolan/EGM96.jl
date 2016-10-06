function module_init()
    # Locate the directory in which the data files are located
    this_filename_dir = dirname(@__FILE__())
    data_dir = joinpath(this_filename_dir, "..", "data")

    # Verify that the CORRCOEF file exists
    corrcoef_filename = joinpath(data_dir, "CORRCOEF")
    @assert isfile(corrcoef_filename)

    # Verify that the EGM96 file exists
    egm96_filename = joinpath(data_dir, "EGM96")
    @assert isfile(egm96_filename)

    # Initialize the f477 C library
    ccall((:init_arrays, libf477),
        Void,
        (Cstring, Cstring),
        corrcoef_filename,
        egm96_filename)
end

# Initialize the module, reading the model data from disk.
module_init()

function undulation(lat::Number, lon::Number)
    return ccall((:undulation, libf477),
        Float64,
        (Float64, Float64, Int, Int),
        deg2rad(lat), deg2rad(lon), 360, 361)
end
