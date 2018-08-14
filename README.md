# Twiddle.jl

[![Latest Release](https://img.shields.io/github/release/Ward9250/Twiddle.jl.svg)](https://github.com/Ward9250/Twiddle.jl/releases/latest)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/Ward9250/Twiddle.jl/blob/master/LICENSE)
[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://Ward9250.github.io/Twiddle.jl/stable)
[![Twiddle](http://pkg.julialang.org/badges/Twiddle_0.7.svg)](http://pkg.julialang.org/?pkg=Twiddle)
[![Twiddle](http://pkg.julialang.org/badges/Twiddle_1.0.svg)](http://pkg.julialang.org/?pkg=Twiddle)
[![Build Status](https://travis-ci.org/Ward9250/Twiddle.jl.svg?branch=develop)](https://travis-ci.org/Ward9250/Twiddle.jl)
[![Build status](https://ci.appveyor.com/api/projects/status/qpu140hq8d5javre/branch/develop?svg=true)](https://ci.appveyor.com/project/Ward9250/twiddle-jl/branch/develop)


## Description

Twiddle is a package collecting useful bit-twiddling tricks, ready to use as
functions, with detailed documentation of what they do, and example real-world
use cases.

This package originated from a PostDoc project where we wanted to do some common
biological sequence operations much much faster than a naive implementation
could, by taking advantage of succinct bit-encoding of the sequences.

This package however is supposed to be more general, and we want it to contain
many bit-twiddling tips and tricks.


## Installation

Install BioSequences from the Julia REPL:

```julia
using Pkg
Pkg.add("Twiddle")
```

If you are interested in the cutting edge of the development, please check out
the master branch to try new features before release.
