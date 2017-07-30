module MVTs

import Base: @pure, @propagate_inbounds, @_pure_meta, @_inline_meta, 
    @_propagate_inbounds_meta, get, getindex, setindex!, view, indices, size, length, 
    summary, show, length, start, next, done, transpose, permutedims, ndims, show, print,
    endof, first, last, names

import Base: ==

export Label, @l_str, labels
export Row, Table

include("Label.jl")
include("symbolic.jl")

include("Relation.jl")
include("Row.jl")
include("Index.jl")
include("Table.jl")

include("projection.jl")
include("join.jl")
include("broadcast.jl")

include("isequal.jl")
#include("symbolic.jl")

end # module
