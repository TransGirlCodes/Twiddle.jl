# Twiddle.jl <small>Bit-twiddling tricks for Julia</small>

Twiddle.jl is a package collecting useful bit-twiddling tricks, ready to use as
functions, with detailed documentation of what they do, and example real-world
use cases.

This package originated from a PostDoc project where we wanted to do some common
biological sequence operations much much faster than a naive implementation
could, by taking advantage of succinct bit-encoding of the sequences.

This package however is supposed to be more general, and we want it to contain
many bit-twiddling tips and tricks.

## Status

[![Build Status](https://travis-ci.org/Ward9250/Twiddle.jl.svg?branch=develop)](https://travis-ci.org/Ward9250/Twiddle.jl)
[![Build status](https://ci.appveyor.com/api/projects/status/qpu140hq8d5javre/branch/develop?svg=true)](https://ci.appveyor.com/project/Ward9250/twiddle-jl/branch/develop)

## Quick Start

Install the latest version of Twiddle.jl from the Julia REPL:

```@example qs
Pkg.add("Twiddle")
```

To use any functions in Twiddle, you must _fully qualify_ the name e.g.

```@example qs
using Twiddle

Twiddle.count_nonzero_nibbles(0x0F11F111F11111F1)
```
