# A `Relation` should support `row ∈ relation` (and `r1 ⨝ r2`)
abstract type Relation{names}; end

@inline names(::Relation{_names}) where {_names} = _names
@inline labels(::Relation{names}) where {names} = labels(names...)
@pure labels(names::Symbol...) = _labels(names...)
@inline _labels(name::Symbol) = (Label{name}(),)
@inline _labels(name::Symbol, other_names...) = (Label{name}(), _labels(other_names...)...)

