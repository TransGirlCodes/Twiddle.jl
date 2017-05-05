#=
Copyright (c) 2017 Ben J. Ward & Luis Yanes

This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at http://mozilla.org/MPL/2.0/.
=#

module Twiddle

"""
    repeatbyte{T<:Unsigned}(::Type{T}, byte::UInt8)

Repeats the bitpattern of the `byte` throughout the an Unsigned integer of
type `T`.

This is useful for bit-twiddling code that is to work on any word size.

Let's use a very simple example to show why this is useful.
Let's say you have a function in which a byte is masked with a bitmask
0x33.

```julia
f(x::UInt8) = x & 0x33
```

Suppose you wanted this to work for any word size, so 8 bit, 16 bit, 32 bit, 64
bit, and 128 bit words? One way is to write `f` as a set of seperate methods:

```julia
f(x::UInt8) = x & 0x33
f(x::UInt16) = x & 0x3333
f(x::UInt32) = x & 0x33333333
f(x::UInt64) = x & 0x3333333333333333
f(x::UInt128) = x & 0x33333333333333333333333333333333
```

This is clearly not ideal, you would be writing out the same method multiplet
times, but with a differently sized literal for the mask each time.

Alternatively, you could write one parametric function with repeatbyte:

```julia
f2{T <: Unsigned}(x::T) = x & Twiddle.repeatbyte(T, 0x33)
```

You might expect this to be less efficient - `repeatbyte` uses several operations
to generate the values 0x33, 0x3333 and so on, whereas in the seperate methods,
those literal values are hard coded. However, thanks to constant folding during
compilation, those operations are done once at compilation time and so the
native instructions generated are identical:

```jlcon
julia> @code_native f(0xFFFFFFFF)
	.section	__TEXT,__text,regular,pure_instructions
Filename: REPL[3]
	pushq	%rbp
	movq	%rsp, %rbp
Source line: 1
	andl	$858993459, %edi        ## imm = 0x33333333
	movl	%edi, %eax
	popq	%rbp
	retq
	nop

julia> @code_native f2(0xFFFFFFFF)
	.section	__TEXT,__text,regular,pure_instructions
Filename: REPL[10]
	pushq	%rbp
	movq	%rsp, %rbp
Source line: 1
	andl	$858993459, %edi        ## imm = 0x33333333
	movl	%edi, %eax
	popq	%rbp
	retq
	nop
```

"""
@inline function repeatbyte{T<:Unsigned}(::Type{T}, byte::UInt8)
    return div(typemax(T), 0xff) * byte
end

include("nibbles.jl")
include("bitpairs.jl")

end
