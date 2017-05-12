# Twiddle.jl

[![Latest Release](https://img.shields.io/github/release/Ward9250/Twiddle.jl.svg)](https://github.com/Ward9250/Twiddle.jl/releases/latest)
[![Twiddle](http://pkg.julialang.org/badges/Twiddle_0.5.svg)](http://pkg.julialang.org/?pkg=Twiddle)
[![Twiddle](http://pkg.julialang.org/badges/Twiddle_0.6.svg)](http://pkg.julialang.org/?pkg=Twiddle)
[![License](https://img.shields.io/badge/license-MPL-green.svg)](https://github.com/Ward9250/Twiddle.jl/blob/master/LICENSE)
[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://Ward9250.github.io/Twiddle.jl/stable)
[![](https://img.shields.io/badge/docs-latest-blue.svg)](https://Ward9250.github.io/Twiddle.jl/latest)

**Development builds:**
[![Build Status](https://travis-ci.org/Ward9250/Twiddle.jl.svg?branch=develop)](https://travis-ci.org/Ward9250/Twiddle.jl)
[![Build status](https://ci.appveyor.com/api/projects/status/qpu140hq8d5javre/branch/develop?svg=true)](https://ci.appveyor.com/project/Ward9250/twiddle-jl/branch/develop)

Twiddle.jl is a package collecting useful bit-twiddling tricks, ready to use as
functions, with detailed documentation of what they do, and example real-world
use cases.

This package originated from a PostDoc project where we wanted to do some common
biological sequence operations much much faster than a naive implementation
could, by taking advantage of succinct bit-encoding of the sequences.

This package however is supposed to be more general, and we want it to contain
many bit-twiddling tips and tricks.
