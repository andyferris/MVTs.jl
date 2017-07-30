
"""
    join(r1::Relation, r2::Relation)

Performs the natural join between two `Relation`s. If two columns share the same name, they
must match on the output. 
"""
function join(r1::Relation, r2::Relation)
    joinlabels = labels(r1) ∩ labels(r2)
    _join(r1, r2, indexes(r1, joinlabels), indexes(r2, joinlabels))
end

#const ⨝ = join