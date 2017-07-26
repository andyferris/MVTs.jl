module MVTs

import Base: @pure, @propagate_inbounds, @_pure_meta, @_inline_meta, 
    @_propagate_inbounds_meta, get, getindex, setindex!, view, indices, size, length, 
    summary, show, length, start, next, done, transpose, permutedims, ndims, show, print,
    endof, first, last
import Base: ==

export Label, @l_str
export Row, Table

include("Label.jl")
include("Row.jl")
include("Table.jl")

end # module
