### A Pluto.jl notebook ###
# v0.14.2

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 4746fb3c-aae8-4e57-805c-627c2ebed25b
begin
	import Pkg
	Pkg.activate(mktempdir())
	Pkg.add([
		Pkg.PackageSpec(name="ImageIO", version="0.5"),
		Pkg.PackageSpec(name="ImageShow", version="0.2"),
		Pkg.PackageSpec(name="FileIO", version="1.6"),
		Pkg.PackageSpec(name="PNGFiles", version="0.3.6"),
		Pkg.PackageSpec(name="Colors", version="0.12"),
		Pkg.PackageSpec(name="ColorVectorSpace", version="0.8"),

		Pkg.PackageSpec(name="PlutoUI", version="0.7"), 
		Pkg.PackageSpec(name="HypertextLiteral", version="0.5"), 
		Pkg.PackageSpec(name="ForwardDiff", version="0.10")
	])

	using Colors, ColorVectorSpace, ImageShow, FileIO
	using PlutoUI
	using HypertextLiteral
	using LinearAlgebra
	using ForwardDiff
end

# ╔═╡ 0a65f4e6-a37e-11eb-21fe-354582f71e13
md"""
## Initialize packages
"""

# ╔═╡ a1f51f9c-086b-40d3-ae70-d8f8f8c62fe5
md"""
# 4.1 Functions in Math and Julia
"""

# ╔═╡ dd6cdd63-b099-4f3b-ba88-0b4002f389d1
md"""
$f_1 = x^2$
$f_2 = sin(x)$
$f_3 = x^\alpha$
"""

# ╔═╡ 71e15a94-b773-4cbc-ae5e-e91696267f9c
f₁(x) = x^2

# ╔═╡ ef737cca-360c-4be4-8067-b48748d6e2e3
f₁(5)

# ╔═╡ eb5ec090-df11-45b6-a380-a7ec2e5ba27f
# anonymous fn
x -> sin(x)

# ╔═╡ 87cb754e-3d55-4b32-b9fb-ffaed012238c
(x -> sin(x))(π/2)

# ╔═╡ a2082be6-c931-4252-afb7-68cf1e6026f9
function f₃(x, α=3)
	return x^α
end

# ╔═╡ 3f8f5da7-aa62-4a7d-a795-cc6504ea315d
f₃(5)

# ╔═╡ 4a926d3d-b5d9-45b0-bf33-b6a481f30617
f₃(5,2)

# ╔═╡ 83ff9a3e-a2e4-4d42-98d5-a3c7ec40b5e9
# what follows the semicolon are kwargs
f₄(x;α) = x^α

# ╔═╡ 4a3246bf-eb9b-4929-928f-527933f7e582
f₄(2, α=5)

# ╔═╡ 006a4801-a9e7-4432-8315-10ca3e0ef8c3
md"""
## 4.1.2 Automatic Differentiation of Univariates
"""

# ╔═╡ d1e87156-6610-42d9-885d-58a4f097f844
ForwardDiff.derivative(f₁, 5)

# ╔═╡ 86959a93-d9fe-4088-9f62-62bf259069b7
ForwardDiff.derivative( x -> f₃(x,3), 5)

# ╔═╡ 2126b79b-6323-49ff-8e1f-6c25dc4d1cbd
@bind e Slider(-6:-1, default=-1, show_value=true)

# ╔═╡ dee30dc5-1c4f-44bb-9f5d-5c2ea2e6634d
ϵ = 10.0^e

# ╔═╡ 62c961e5-876e-44ee-b3bf-610b51ead1c7
(sin(1+ϵ) - sin(1))/ϵ, cos(1), ForwardDiff.derivative(sin, 1)

# ╔═╡ ae541dd9-d6c2-43dc-b1d2-a8bc95a0f8ae
md"""
## 4.1.3. Scalar Valued Multivariate Functions
"""

# ╔═╡ 65022607-9016-46d2-8fdf-104c9558d2e0
md"""
$f\_5 = 5sin(x_1 * x_2) + 2x_2/4x_3$
"""

# ╔═╡ b2a32993-0430-4a73-9c20-b02961c51009
begin
	f₅(v) = 5sin(v[1] * v[2]) + 2v[2]/4v[3]
	f₅(x,y,z) = 5sin(x*y) + 2y/4z
end

# ╔═╡ 65a2d05b-be8c-42f0-a2ee-340593aeaf5b
f₅([1,2,3]), f₅(1,2,3)

# ╔═╡ a8a8bcd9-ba65-450e-8dff-40c32d64508b
begin
	# Alternatively, write fn with x,y,z and create a vectorizer
	f₆(x,y,z) = 5sin(x*y) + 2y/4z
	f₆(v) = f₆(v[1], v[2], v[3])
end

# ╔═╡ c996c48c-2379-40a1-8db6-a0e6d41eb16a
# Another trick
f₆((x,y,z)) = 5sin(x*y) + 2y/4z

# ╔═╡ 0d5a3b45-22da-458c-bf4f-2266346ae889
f₆(1,2,3), f₆([1,2,3])

# ╔═╡ 617a30da-2cfa-4c01-a779-7a59d9e9e0a7
f₆([1,2,3])

# ╔═╡ 12ae2cbe-45dd-42b8-8c9b-66c2f0ec0e98
methods(f₅)

# ╔═╡ 2b621241-da2f-474e-8ff6-7eb989cc1141
md"""
## 4.1.4 Automatic Differentiation: Scalar valued multivariate functions
"""

# ╔═╡ 6988b802-b555-4156-a4de-c6dd229262d5
# This will fail, as derivative works only on real numbers
ForwardDiff.derivative(f₅, [1,2,3])

# ╔═╡ 60e4ad53-af7b-4aa1-aaec-6ccfc1df2a08
ForwardDiff.gradient(f₅, [1,2,3])

# ╔═╡ dbe1fa75-fbe6-4460-8eee-7ffb599fceb4
begin
	# \partial = ∂
	original = f₅([1,2,3])
	
	∂f₅∂x = (f₅(1+ϵ, 2, 3) - original) / ϵ
	∂f₅∂y = (f₅(1, 2+ϵ, 3) - original) / ϵ
	∂f₅∂z = (f₅(1, 2, 3+ϵ) - original) / ϵ
	
	∇f = [∂f₅∂x, ∂f₅∂y, ∂f₅∂z]
end

# ╔═╡ b0a1cff8-434a-49da-a053-1cd64d50b319
md"""
## 4.1.5 Transformations: Vector Valued Multivariate Functions
"""

# ╔═╡ f1a6a8e4-04f8-499a-b873-6131320fb7f0
begin
	identity((x,y)) = [x,y]
	lin1((x,y)) = [ 2x+3y , -5x+4y]
	scalex(α) = ((x,y),) -> [α*x, y]
	scaley(α) = ((x,y),) -> [x, α*y]
	rot(θ) = ((x,y),) -> [cos(θ)*x + sin(θ)*y, -sin(θ)*x + cos(θ)*y]
	shear(α) = ((x, y),) -> [x+α*y, y]
	genlin(a,b,c,d) = ((x, y),) -> [a*x + b*y; c*x + d*y]
end

# ╔═╡ 89caaf1c-1a4b-4a0d-af05-dd7181b040cd
rot(π/2)([4, 5])

# ╔═╡ f862276d-9376-4414-8754-94615aa371f2
#methods(norm)

# ╔═╡ 7909f8b2-9abc-4bcc-9616-44c01f946024
√4

# ╔═╡ de57fac5-2b16-4e70-917a-4adf884bdfab
begin 
	warp₂(α, x, y) = rot(α* √(x^2 + y^2))
	warp₂(α) = ((x,y),) -> warp₂(α,x,y)([x,y])
end

# ╔═╡ 519d61d9-43e7-488b-af81-138631971c55
warp₂(1,5,6)([5,6])

# ╔═╡ 04fb9d7d-004c-4532-a4c0-658badef037c
warp₂(1)([5,6])

# ╔═╡ 72821f10-c64a-4465-97cc-b91a545400fe
md"""
## 4.1.6 Automatic Differentiation of Transforms
"""

# ╔═╡ d9441877-534e-4470-9cac-40ba83b67f6a
ForwardDiff.jacobian(warp₂(3.0), [4,5])

# ╔═╡ 2c0d67b6-5a9b-423f-b2d2-1b7cb819fc94
typeof([4,5])

# ╔═╡ 0a6df22e-e474-46cb-bda3-1df6dfe4b220
typeof([4 5])

# ╔═╡ a8b39178-f971-442c-b1b3-91b1ad5cd0b3
begin 
	original_w = warp₂(3)([4,5])
	
	∂w∂x = (warp₂(3)([4+ϵ, 5]) - original_w) / ϵ
	∂w∂y = (warp₂(3)([4, 5+ϵ]) - original_w) / ϵ
	
	[∂w∂x ∂w∂y]
end

# ╔═╡ 5cd6f9de-3df1-418a-b53e-f481d3b6cfa4
md"""
α = $(@bind α Slider(.1:.1:3, show_value=true))
"""

# ╔═╡ 9a770879-0d04-4398-8a67-1b155866abfa
begin 
	range = -1.5:.1:1.5
	md"""
	``(`` 
	 $(@bind a Scrubbable( range; default=1.0))
	 $(@bind b Scrubbable( range; default=0))
	``)``
	
	``(``
	 $(@bind c Scrubbable( range; default=0))
	 $(@bind d Scrubbable( range; default=1.0))
	``)``

	"""
end

# ╔═╡ 9a20618e-6905-4028-951e-1fb3af834455
# T = genlin(a,b,c,d)
T = warp₂(α)

# ╔═╡ 69eda93f-e2bf-40dd-843b-0d0447d0c0da
md"""
top left zoom = $(@bind z Slider(.1:.1:3, show_value=true, default=1))

center zoom =	$(@bind f Slider(.1:.1:3, show_value=true, default=1))

show grid lines $(@bind show_grid CheckBox(default=true))

"""

# ╔═╡ 990f758f-f44b-44a1-95c0-4ed3b96ccacd
md"""
## Appendix
"""

# ╔═╡ 96f83dfb-db41-4ec5-a411-7dbe0df71d07
img_sources = [
	"https://user-images.githubusercontent.com/6933510/108605549-fb28e180-73b4-11eb-8520-7e29db0cc965.png" => "Corgis",
	"https://user-images.githubusercontent.com/6933510/108883855-39690f80-7606-11eb-8eb1-e595c6c8d829.png" => "Arrows",
	"https://images.squarespace-cdn.com/content/v1/5cb62a904d546e33119fa495/1589302981165-HHQ2A4JI07C43294HVPD/ke17ZwdGBToddI8pDm48kA7bHnZXCqgRu4g0_U7hbNpZw-zPPgdn4jUwVcJE1ZvWQUxwkmyExglNqGp0IvTJZamWLI2zvYWH8K3-s_4yszcp2ryTI0HqTOaaUohrI8PISCdr-3EAHMyS8K84wLA7X0UZoBreocI4zSJRMe1GOxcKMshLAGzx4R3EDFOm1kBS/fluffy+corgi?format=2500w" => "Long Corgi"
]

# ╔═╡ 239fe6ca-e940-4b43-898e-4714ab51fb40
md"""
#### Choose an image
$(@bind img_source Select(img_sources))
"""

# ╔═╡ a4211d14-30b6-4162-9a32-b982e0d2cbf6
img_original = load(download(img_source));

# ╔═╡ a5f76b12-da74-4fae-b9b1-d4cdf04c91d7
begin
	white(c::RGB) = RGB(1,1,1)
	white(c::RGBA) = RGBA(1,1,1,0.75)
end

# ╔═╡ 114dac3d-a659-4a16-9626-83ceb5fbab12
function trygetpixel(img::AbstractMatrix, x::Float64, y::Float64)
	rows, cols = size(img)
	
	"The linear map [-1,1] ↦ [0,1]"
	f = t -> (t - -1.0)/(1.0 - -1.0)
	
	i = floor(Int, rows *  f(-y) / z)
	j = floor(Int, cols *  f(x * (rows / cols))  / z)
 
	if 1 < i ≤ rows && 1 < j ≤ cols
		img[i,j]
	else
		white(img[1,1])

	end
end

# ╔═╡ 2adccee7-71b3-4d9f-88cc-5616a32f57c6
function with_gridlines(img::Array{<:Any,2}; n=16)
	
	sep_i = size(img, 1) ÷ n
	sep_j = size(img, 2) ÷ n
	
	result = copy(img)
	# stroke = zero(eltype(img))#RGBA(RGB(1,1,1), 0.75)
	
	stroke = RGBA(1, 1, 1, 0.75)
	
	result[1:sep_i:end, :] .= stroke
	result[:, 1:sep_j:end] .= stroke

	# a second time, to create a line 2 pixels wide
	result[2:sep_i:end, :] .= stroke
	result[:, 2:sep_j:end] .= stroke
	
	 result[  sep_i * (n ÷2) .+ [1,2]    , :] .= RGBA(0,1,0,1)
	result[ : ,  sep_j * (n ÷2) .+ [1,2]    ,] .= RGBA(1,0,0,1)
	return result
end

# ╔═╡ 49ed71ac-ccae-4bd3-be85-1666a4a1c699
img = if show_grid
	with_gridlines(img_original)
else
	img_original
end;

# ╔═╡ 695ee39f-cd7c-4276-9077-c9731023e391
begin
	A = [a b; c d]
	det_A = 1.0
	[
		if det(A) == 0
			RGB(1.0, 1.0, 1.0)
		else
			
			 # in_x, in_y = A \ [out_x, out_y]
	         # in_x, in_y = xy( [out_x, out_y] )
			in_x, in_y =  T([out_x, out_y])
			trygetpixel(img, in_x, in_y)
		end
		
		for out_y in LinRange(f, -f, 500),
			out_x in LinRange(-f, f, 500)
	]
end

# ╔═╡ Cell order:
# ╟─0a65f4e6-a37e-11eb-21fe-354582f71e13
# ╠═4746fb3c-aae8-4e57-805c-627c2ebed25b
# ╟─a1f51f9c-086b-40d3-ae70-d8f8f8c62fe5
# ╟─dd6cdd63-b099-4f3b-ba88-0b4002f389d1
# ╠═71e15a94-b773-4cbc-ae5e-e91696267f9c
# ╠═ef737cca-360c-4be4-8067-b48748d6e2e3
# ╠═eb5ec090-df11-45b6-a380-a7ec2e5ba27f
# ╠═87cb754e-3d55-4b32-b9fb-ffaed012238c
# ╠═a2082be6-c931-4252-afb7-68cf1e6026f9
# ╠═3f8f5da7-aa62-4a7d-a795-cc6504ea315d
# ╠═4a926d3d-b5d9-45b0-bf33-b6a481f30617
# ╠═83ff9a3e-a2e4-4d42-98d5-a3c7ec40b5e9
# ╠═4a3246bf-eb9b-4929-928f-527933f7e582
# ╠═006a4801-a9e7-4432-8315-10ca3e0ef8c3
# ╠═d1e87156-6610-42d9-885d-58a4f097f844
# ╠═86959a93-d9fe-4088-9f62-62bf259069b7
# ╠═2126b79b-6323-49ff-8e1f-6c25dc4d1cbd
# ╟─dee30dc5-1c4f-44bb-9f5d-5c2ea2e6634d
# ╠═62c961e5-876e-44ee-b3bf-610b51ead1c7
# ╟─ae541dd9-d6c2-43dc-b1d2-a8bc95a0f8ae
# ╠═65022607-9016-46d2-8fdf-104c9558d2e0
# ╠═b2a32993-0430-4a73-9c20-b02961c51009
# ╠═65a2d05b-be8c-42f0-a2ee-340593aeaf5b
# ╠═a8a8bcd9-ba65-450e-8dff-40c32d64508b
# ╠═0d5a3b45-22da-458c-bf4f-2266346ae889
# ╠═c996c48c-2379-40a1-8db6-a0e6d41eb16a
# ╠═617a30da-2cfa-4c01-a779-7a59d9e9e0a7
# ╠═12ae2cbe-45dd-42b8-8c9b-66c2f0ec0e98
# ╟─2b621241-da2f-474e-8ff6-7eb989cc1141
# ╠═6988b802-b555-4156-a4de-c6dd229262d5
# ╠═60e4ad53-af7b-4aa1-aaec-6ccfc1df2a08
# ╠═dbe1fa75-fbe6-4460-8eee-7ffb599fceb4
# ╟─b0a1cff8-434a-49da-a053-1cd64d50b319
# ╠═f1a6a8e4-04f8-499a-b873-6131320fb7f0
# ╠═89caaf1c-1a4b-4a0d-af05-dd7181b040cd
# ╠═f862276d-9376-4414-8754-94615aa371f2
# ╠═7909f8b2-9abc-4bcc-9616-44c01f946024
# ╠═de57fac5-2b16-4e70-917a-4adf884bdfab
# ╠═519d61d9-43e7-488b-af81-138631971c55
# ╠═04fb9d7d-004c-4532-a4c0-658badef037c
# ╟─72821f10-c64a-4465-97cc-b91a545400fe
# ╠═d9441877-534e-4470-9cac-40ba83b67f6a
# ╠═2c0d67b6-5a9b-423f-b2d2-1b7cb819fc94
# ╠═0a6df22e-e474-46cb-bda3-1df6dfe4b220
# ╠═a8b39178-f971-442c-b1b3-91b1ad5cd0b3
# ╟─239fe6ca-e940-4b43-898e-4714ab51fb40
# ╟─5cd6f9de-3df1-418a-b53e-f481d3b6cfa4
# ╟─9a770879-0d04-4398-8a67-1b155866abfa
# ╠═9a20618e-6905-4028-951e-1fb3af834455
# ╟─69eda93f-e2bf-40dd-843b-0d0447d0c0da
# ╟─695ee39f-cd7c-4276-9077-c9731023e391
# ╟─990f758f-f44b-44a1-95c0-4ed3b96ccacd
# ╟─96f83dfb-db41-4ec5-a411-7dbe0df71d07
# ╠═a4211d14-30b6-4162-9a32-b982e0d2cbf6
# ╠═49ed71ac-ccae-4bd3-be85-1666a4a1c699
# ╠═114dac3d-a659-4a16-9626-83ceb5fbab12
# ╠═a5f76b12-da74-4fae-b9b1-d4cdf04c91d7
# ╠═2adccee7-71b3-4d9f-88cc-5616a32f57c6
