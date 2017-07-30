struct Label{Name}; end

@pure Label(name::Symbol) = Label{name}()

macro l_str(ex)
    return Label(Symbol(ex::String))
end

@pure (==)(::Label{Name}, ::Label{Name}) where {Name} = true
@pure (==)(::Label{Name1}, ::Label{Name2}) where {Name1, Name2} = false

show(io::IO, ::Label{Name}) where {Name} = print(io, "l\"$(Name)\"")
print(io::IO, ::Label{Name}) where {Name} = print(io, Name)

@pure function label_to_index(names::Tuple{Vararg{Symbol}}, ::Label{name}) where name
    for i = 1:length(names)
        if names[i] == name
            return i
        end
    end
    error("Could not find $name in $names")
end

@inline getnames(x::Tuple{Vararg{Pair{<:Label}}}) = _getnames(x...)
@inline _getnames(::Pair{Label{name}}, x...) where {name} = (name, _getnames(x...)...)
@inline _getnames() = ()

@inline getvalues(x::Tuple{Vararg{Pair}}) = _getvalues(x...)
@inline _getvalues(x::Pair, y...)  = (last(x), _getvalues(y...)...)
@inline _getvalues() = ()

@pure function Base.issubset(x::Tuple{Vararg{Label}}, y::Tuple{Vararg{Label}})
    for l ∈ x
        if l ∉ y
            return false
        end
    end
    return true
end

@pure function Base.union(x::Tuple{Vararg{Label}}, y::Tuple{Vararg{Label}})
    out = x
    for l ∈ y
        if l ∉ x
            out = (out..., l)
        end
    end
    return out
end

@pure function Base.intersect(x::Tuple{Vararg{Label}}, y::Tuple{Vararg{Label}})
    out = ()
    for l ∈ x
        if l ∈ y
            out = (out..., l)
        end
    end
    return out
end
