# MVTs

Minimal viable tables (for Julia 0.6)

[![Build Status](https://travis-ci.org/andyferris/MVTs.jl.svg?branch=master)](https://travis-ci.org/andyferris/MVTs.jl)

[![Coverage Status](https://coveralls.io/repos/andyferris/MVTs.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/andyferris/MVTs.jl?branch=master)

[![codecov.io](http://codecov.io/github/andyferris/MVTs.jl/coverage.svg?branch=master)](http://codecov.io/github/andyferris/MVTs.jl?branch=master)

This is an experimental framework to provide the following feature set:

 * Fast, type-stable data tables
 * Arbitrary and extensible accelration (and uniqueness) indices applied to a table
 * Primitive operations (projections & natural joins) that are acceleration-index aware
 * Some acceptable user-level syntax for constructing the primitives

If this proof-of-concept works out, I may apply any learnings to Tabulars.jl, TypedTables.jl, etc.

Current functionality is limited to the basic definitions of rows and tables.

### The desired implementation (WIP)

`Relation{names}` is an abstract type representing a possibly infinite set (or bag) of
named tuples, with the column names `names` as a tuple of `Symbol`s. `Relation`s are containers of `Row`s, which
is our local implementation of named tuples. For type stability and disambiguity with, 
`Symbol`s, users will interact with names as `Label{:name}()` which can be constructed simply
by the non-standard string literal `l"name"` and extracted by `labels(relation)`.

`Table{names}` is a concrete container which uses column-based storage of `Row`s, and can
be accessed similarly to a `Vector{Row{names}}`. `Table`s can also carry one or more `Index`es.

An `Index{names}` is an acceleration index used to make lookup of values in the specified 
columns faster. Some `Index`es also represent uniqueness, these are `UniqueIndex`es.

There are also more abstract `Relation`s. These might represent infinite sets such as
`l"a" < l"b"` which gives the relation of all possible rows where `row[l"a"] < row[l"b"]`.
Such a relation is not useful on it's own, but can participate in a `join` to result in a
finite relation. 

There are two elementary operations, projections and joins. These operations will be lazy
wherever possible; a set of operations should end in `collect` to create a `Table` if
desired.

Projections can remove, add or rename columns, and the appropriate `Index`es should be
preserved (and if a column which takes part in an `Index` is removed, then that `Index` is
also discarded). 

Joins in *MVTs.jl* are natural inner joins which match up column names and concatenate
rows which are equal on their overlapping portion. A `join` operation will attempt to use 
any available `Index` to accelerate the join operation. Three-or-more relations may
participate in a join operations.

We will also implement broadcasting so that two tables of the same length can perform
operations on their individual rows.