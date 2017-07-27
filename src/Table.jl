struct Table{names, T <: Tuple{Vararg{AbstractVector}}} <: Relation{names}
    data::T
end

@inline Table(in::Pair{<:Label}...) = Table{getnames(in)}(getvalues(in))
@inline Table{names}(in::Tuple) where {names} = Table{names, typeof(in)}(in)

@inline start(t::Table) = start(first(t.data))
@inline next(t::Table, i) = next(first(t.data), i)
@inline done(t::Table, i) = done(first(t.data), i)

@inline length(t::Table) = length(first(t.data))
@inline endof(t::Table) = endof(first(t.data))

@inline first(t::Table) = @inbounds return t[1]
@inline last(t::Table) = @inbounds return t[end]

@generated function getindex(t::Table{names}, i::Integer) where {names}
    expr = [:(t.data[$j][i]) for j = 1:length(names)]
    return quote
        @_propagate_inbounds_meta
        Row{names}(tuple($(expr...)))
    end
end

@generated function getindex(t::Table{names}, i) where {names}
    expr = [:(t.data[$j][i]) for j = 1:length(names)]
    return quote
        @_propagate_inbounds_meta
        Table{names}(tuple($(expr...)))
    end
end

function show(io::IO, table::Table)
    n = length(table)
    println(io, "Table with $n rows")
    for i = 1:min(n, 5)
        print(io, " ", table[i])
        if i != min(n, 5)
            print(io, "\n")
        end
    end
    if n > 5
        print(io, "\n ...")
    end
end