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

# ╔═╡ d0c21c3c-a121-11eb-0d0c-792e5fbbdb37
begin
	using Pkg
	Pkg.activate(mktempdir())
	Pkg.add(["PlutoUI", "Images", "ImageMagick"])
	using PlutoUI
	using Images
end

# ╔═╡ 0950742a-8367-4d4d-a38c-5cdb79c00179
md"""
# 1.2 Introduction to Abstractions
"""

# ╔═╡ 594e3e75-2a49-4829-9001-009c5f22d780
begin
	oneimage = load(download("https://gallery.yopriceville.com/var/albums/Free-Clipart-Pictures/Decorative-Numbers/Cute_Number_One_PNG_Clipart_Image.png?m=1437447301"))
	corgi = load(download("https://i.barkpost.com/wp-content/uploads/2015/01/corgi2.jpg?q=70&fit=crop&crop=entropy&w=808&h=500"))
	nothing
end


# ╔═╡ a5fef3bb-dc9a-4e91-9770-1c6e06dc6b7b
nothing

# ╔═╡ 295d432d-21c1-4b1d-a678-2549b3431978
md"""
## What is _one_?
"""

# ╔═╡ b5249b53-cda1-4e86-b26a-1d9553a137d0
one = [1, 1.0, "one" , 1//1, oneimage, [1 0; 0 1], corgi] # a corgi is a singular dog

# ╔═╡ d8396331-5afe-4591-b1ba-9eb2f2e05f47
begin
	one_keys = ["1", "1.0", "one", "1//1", "Cute One", "2x2 Identity", "One Corgi"]
	selections = one_keys .=> one_keys
	lookup_element = Dict(one_keys .=> one)
	nothing
end

# ╔═╡ b4a2d40b-efc1-4f81-9d8d-dcc3a084a010
@bind element_key Select(selections)

# ╔═╡ 820ce71e-f29e-4ca0-9d25-1b879c1b8522
element = lookup_element[element_key]

# ╔═╡ 1f4df786-258d-4482-a545-f211343ac9d7
typeof(element)

# ╔═╡ ec8239d8-4249-4855-b5e6-4b182396c687
array = fill(element, 3,4)

# ╔═╡ 7d5cb7ba-3f22-4556-a9d8-481660f0b9a8
function insert(el, matrix, i, j)
	B = copy(matrix)
	B[i, j] = el
	return B
end

# ╔═╡ 6ba7a0d2-2f27-4edf-ae4d-d42f1b65b051
begin 
	rows = 4
	cols = 4
	md"""
	x: $(@bind x Slider(1:rows, show_value=true))
	y: $(@bind y Slider(1:cols, show_value=true))
	"""
end

# ╔═╡ d7e7af6b-34bc-4c65-93da-b00e693f54de
begin
	one_number_array = fill(1, rows, cols)
	insert(5, one_number_array, x, y)
end

# ╔═╡ a2ee20aa-4b28-4374-bece-d838de334b81
begin
	one_image_array = fill(oneimage, rows, cols)
	insert(corgi, one_image_array, x, y)
end

# ╔═╡ c61a11c4-6c06-4cc2-81b1-96111e46695e
md"""
## Conclusion
The key idea here is that a computer language should allow you to do operations that make sense. Often times, an operation can make sense for many different objects. So we can abstract away the specifics of the object in our implementation. It should let you step back from there
"""

# ╔═╡ Cell order:
# ╟─0950742a-8367-4d4d-a38c-5cdb79c00179
# ╠═d0c21c3c-a121-11eb-0d0c-792e5fbbdb37
# ╠═594e3e75-2a49-4829-9001-009c5f22d780
# ╠═a5fef3bb-dc9a-4e91-9770-1c6e06dc6b7b
# ╟─295d432d-21c1-4b1d-a678-2549b3431978
# ╠═b5249b53-cda1-4e86-b26a-1d9553a137d0
# ╠═d8396331-5afe-4591-b1ba-9eb2f2e05f47
# ╠═b4a2d40b-efc1-4f81-9d8d-dcc3a084a010
# ╠═820ce71e-f29e-4ca0-9d25-1b879c1b8522
# ╠═1f4df786-258d-4482-a545-f211343ac9d7
# ╠═ec8239d8-4249-4855-b5e6-4b182396c687
# ╠═7d5cb7ba-3f22-4556-a9d8-481660f0b9a8
# ╠═6ba7a0d2-2f27-4edf-ae4d-d42f1b65b051
# ╠═d7e7af6b-34bc-4c65-93da-b00e693f54de
# ╠═a2ee20aa-4b28-4374-bece-d838de334b81
# ╟─c61a11c4-6c06-4cc2-81b1-96111e46695e
