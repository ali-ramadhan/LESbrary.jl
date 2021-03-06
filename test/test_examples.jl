include("run_script.jl")

@testset "Examples" begin
    #####
    ##### Free convection example
    #####

    free_convection_filepath = joinpath(@__DIR__, "..", "examples", "free_convection.jl")

    replace_strings = [
        ("size=(32, 32, 32)", "size=(1, 1, 1)"),
        ("TimeInterval(4hour)", "TimeInterval(2minute)"),
        ("AveragedTimeInterval(1hour, window=15minute)", "AveragedTimeInterval(2minute, window=1minute)"),
        ("iteration_interval=100", "iteration_interval=1"),
        ("stop_time=8hour", "stop_time=2minute")
    ]

    @test run_script(replace_strings, "free_convection", free_convection_filepath)

    push!(replace_strings, ("CPU()", "GPU()"))
    @test_skip run_script(replace_strings, "free_convection", free_convection_filepath)

    #####
    ##### Three layer constant fluxes example
    #####

    three_layer_constant_fluxes_filepath = joinpath(@__DIR__, "..", "examples", "three_layer_constant_fluxes.jl")

    replace_strings = [
        ("Pkg.instantiate()", ""),
        ("using Pkg", ""),
        ("default = [32, 32, 32]", "default = [1, 1, 1]"),
        ("architecture = GPU()", "architecture = CPU()"),
        ("if make_animation", "if false")
    ]

    @test run_script(replace_strings, "three_layer_constant_fluxes", three_layer_constant_fluxes_filepath)
end
