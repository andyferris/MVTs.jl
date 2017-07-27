@testset "Row" begin
    @test Row(l"a" => 1, l"b" => 2.0) === Row{(:a, :b), Tuple{Int, Float64}}((1, 2.0))

    row = Row(l"a" => 1, l"b" => 2.0)
    @test @inferred(row[l"a"]) === 1
    @test @inferred(row[l"b"]) === 2.0
    @test_throws ErrorException row[l"c"]

    @test names(row) === (:a, :b)
    @test @inferred(labels(row)) === (l"a", l"b")
end