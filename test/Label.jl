@testset "Label" begin
    @test l"abc" === Label{:abc}()
    @test l"abc" == l"abc"
    @test l"abc" != l"def"
    
    @test MVTs.label_to_index((:abc, :def), l"abc") == 1
    @test MVTs.label_to_index((:abc, :def), l"def") == 2
    @test_throws ErrorException MVTs.label_to_index((:abc, :def), l"ghi")
end