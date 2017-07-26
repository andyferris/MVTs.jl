# MVTs

Minimal viable tables (for Julia 0.6)

[![Build Status](https://travis-ci.org/andyferris/MVTs.jl.svg?branch=master)](https://travis-ci.org/andyferris/MVTs.jl)

[![Coverage Status](https://coveralls.io/repos/andyferris/MVTs.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/andyferris/MVTs.jl?branch=master)

[![codecov.io](http://codecov.io/github/andyferris/MVTs.jl/coverage.svg?branch=master)](http://codecov.io/github/andyferris/MVTs.jl?branch=master)

This is an experimental framework to provide the following feature set:

 * Fast, type-stable data tables
 * Arbitrary and extensible accelration (and uniqueness) indices applied to a table
 * Primitive operations (projections & natural joins) that are acceleration-index aware
 * Some acceptable user-level syntax for constructing the primtives

If this proof-of-concept works out, I may apply any learnings to Tabulars.jl, TypedTables.jl, etc.

Current functionality is limited to the basic definitions of rows and tables.