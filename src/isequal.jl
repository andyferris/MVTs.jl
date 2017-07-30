# A simple relation that uses hash-based lookup
struct IsEqualRelation{names, T <: Tuple} <: Relation{names}
    values::T
end

Base.isequal(::Label{name}, value) where {name} = IsEqualRelation{(name,)}((value,))

Base.iteratorsize(::Type{<:IsEqualRelation}) = Base.HasLength()
Base.length(::IsEqualRelation) = 1
Base.start(::IsEqualRelation) = false
Base.next(r::IsEqualRelation{names}, i) = (Row{names}(r.values), true)
Base.done(::IsEqualRelation, i) = i
Base.first(r::IsEqualRelation) = Row{names}(r.values)

# Hash-based lookup table
struct UniqueHashIndex{names, T} <: UniqueIndex{names}
    hashmap::Dict{T, Int}
end

function UniqueHashIndex{hashnames}(t::Table{names}) where {hashnames, names}
    HashIndex{hashnames}(t::Table[labels(hashnames)...])
end

function UniqueHashIndex{names}(t::Table{names}) where {names}
    T = eltype(t, labels(names))
    hashmap = Dict{T, Int}()
    for i = 1:length(t)
        @inbounds row = t[i]
        hashmap[row] = i
    end
    return UniqueHashIndex{names, T}(hashmap)
end

function makeindex(t::Table, UniqueHashIndex{names})
    
end

