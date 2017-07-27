@testset "Table" begin
    v1 = [1,2]
    v2 = [2.0, 4.0]
    @test @inferred(Table(l"a" => v1, l"b" => v2)) isa Table{(:a, :b), Tuple{Vector{Int}, Vector{Float64}}}

    table = Table(l"a" => v1, l"b" => v2)
    @test @inferred(table[1]) === Row(l"a" => 1, l"b" => 2.0)
    @test @inferred(table[2]) === Row(l"a" => 2, l"b" => 4.0)
    @test_throws BoundsError  table[3]

    @test names(table) == (:a, :b)
    @test @inferred(labels(table)) == (l"a", l"b")
end