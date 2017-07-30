struct Row{names, T <: Tuple}
    data::T
end

@inline Row(in::Pair{<:Label}...) = Row{getnames(in)}(getvalues(in))
@inline Row{names}(in::Tuple) where {names} = Row{names, typeof(in)}(in)

@inline getindex(row::Row{names}, l::Label) where {names} = row.data[label_to_index(names, l)]

function show(io::IO, row::Row{names}) where names
    print(io, "Row(")
    for i ∈ 1:length(names)
        print(io, "l", '"', names[i], '"', " => ", row.data[i])
        if i != length(names)
            print(io, ", ")
        end
    end
    print(io, ")")
end

@inline names(::Row{_names}) where {_names} = _names
@inline labels(::Row{names}) where {names} = labels(names...)

Base.hash(r::Row, h::UInt) = hash(r.data, h)
