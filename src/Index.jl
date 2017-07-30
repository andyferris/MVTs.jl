
# An acceleration index that helps do a `join` over the listed columns
abstract type Index{names}; end

@inline labels(i::Index{names}) = _labels(names...)

# Similar to above but the values are unique
abstract type UniqueIndex{names} <: Index{names}; end

# There is no acceleration but the assertion of uniqueness may make joins, etc, faster.
struct Unique{names} <: UniqueIndex{names}
end