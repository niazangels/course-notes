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

# ╔═╡ cb3667da-175f-4b09-a1d3-4600392bc545
import Pkg; Pkg.add("PlutoUI")

# ╔═╡ 95c832b2-1669-48fb-9a79-3a78bf674d63
begin
	using Images
	philip = load("philip.jpg")
end

# ╔═╡ c2db34c5-8f50-4dca-b857-d8833d366944
using PlutoUI

# ╔═╡ 6f62ccca-a06f-11eb-3681-5de363807f78
# url = "https://i.imgur.com/VGPeJ6s.jpg"

# ╔═╡ 239240d6-aa3a-47e1-b6d7-01bfba9f1db6
# download(url, "philip.jpg")

# ╔═╡ 1f47858d-48c0-4cba-80b9-d8f521da04d1
typeof(philip)

# ╔═╡ 1962c789-bde6-43bd-910c-0a5a3ae69bbf
RGB(0.8, 0.01, 0.02)

# ╔═╡ f7ec05aa-2470-4a78-afeb-a301ebc1931f
size(philip)

# ╔═╡ c49ba928-1f22-4a69-9c5f-eb4da0e0edfe
philip[1000,400]

# ╔═╡ 61d7c626-1c05-4522-a5bf-35e8547af8bf
philip[1:1000, 1:400]

# ╔═╡ 108dcd52-e7ec-4585-907f-d64150c7156b
collect(1:10)

# ╔═╡ 1398ff50-bdd8-4a7f-b05e-b22558147f37
begin
	(h,w) = size(philip)
	head = philip[(h ÷ 2):h, (w ÷ 10): (9w ÷ 10)]
	# ÷ is integer division - you type it as \div <TAB>
end

# ╔═╡ 54b5ea2e-395a-44ca-b301-cd4155fc458a
3 ÷ 2

# ╔═╡ 9c348636-7bd0-45f6-bdf5-926c27313e78
size(head)

# ╔═╡ f94df369-445c-49eb-8b7f-fd3da1915872
[head head]

# ╔═╡ b9785995-9da1-4fa8-a4f3-ac03c96dae48
[ head 			reverse(head, dims=2)
reverse(head, dims=1)	reverse(reverse(head, dims=1), dims=2)]

# ╔═╡ 44710ae8-6558-4b87-af2b-726025441517
new_phil = copy(head)

# ╔═╡ 2b425505-8910-4782-80b1-ce98442bd4d4
new_phil[550:950, :]

# ╔═╡ 9ff63b16-cc92-4b3c-b197-5427385df870
new_phil[550, :]

# ╔═╡ 4540acad-0e08-4cc4-b523-5fc9257c7a8b
@bind range_rows RangeSlider(1:size(new_phil)[1], show_value=true)

# ╔═╡ c9b0f7e0-a330-4e41-90df-144809912c3b
@bind range_cols RangeSlider(1:size(new_phil)[2], show_value=true)

# ╔═╡ cbe33d74-554a-4f01-ad88-65f1e86a6935
nose = new_phil[range_rows, range_cols]

# ╔═╡ 24d672c1-ab80-4872-bba5-4942f5dfd2f5
red = RGB(1, 0, 0)

# ╔═╡ 992a6d37-c779-46d9-a86d-6433812152c3
begin
	for i in 1:100
		for j in 1:300
			new_phil[i,j] = red
		end
	end
end

# ╔═╡ 2c314d20-2dc8-4ffe-8fef-6e915b7ec555
new_phil

# ╔═╡ 26d8c359-d296-4c3c-9172-b00b29628318
begin
	new_phil2 = copy(new_phil)
	new_phil2[100:200, 1:300] .= RGB(0, 0, 1)
	new_phil2
end

# ╔═╡ 13de49f4-0bfe-4061-922d-61f9e48743a6
function redify(color::AbstractRGB)
	return RGB(color.r, 0, 0)
end

# ╔═╡ 47b3942c-3f54-49aa-a640-37aee25ba15f
begin
	color = RGB(.8, .5, .2)
	[color, redify(color)]
end

# ╔═╡ 6642901b-e19d-4c52-adff-2fa0dd5efce7
redify(new_phil)

# ╔═╡ e23252ef-eecb-4068-b3d8-121194b7a4e5
redify.(new_phil)

# ╔═╡ 3ddcb149-5a4b-453a-bef0-980af79f1ad4
3/2

# ╔═╡ dad9f88b-06c3-45a4-bfa7-2e25100339ed
function greyscale(color::AbstractRGB)
	avg = (0.299color.r + 0.587color.g + 0.114color.b)
	return RGB(avg, avg, avg)
end

# ╔═╡ 9abf35ad-8308-4c91-a5db-5daa8c3243ee
begin
	clr = RGB(.8, .2, .1)
	[clr , greyscale(clr)]
end

# ╔═╡ bfbb9b7c-763a-4aa5-92d0-70fa5aefc124
greyscale.(new_phil)

# ╔═╡ 828b03f8-9290-45ae-aa85-f0ac43efadf6
function invert(color::AbstractRGB)
	return RGB(1 - color.r, 1 - color.g , 1 - color.b)
end

# ╔═╡ 8b990bf0-f9a7-438a-aa62-970a3fda9b64
invert.(new_phil)

# ╔═╡ 24811842-4f45-4344-bfc2-821689e10c40
decimate(new_phil, 3)

# ╔═╡ 224ff9ef-2f0a-4cec-b9af-5475f4bc8439
convo

# ╔═╡ 26f91556-3d9c-47e0-8df8-6e15aca1ff7e
md"""
#### Exercise 1.2

👉 Generate a vector of 100 zeros. Change the center 20 elements to 1.
"""

# ╔═╡ 44624703-7f91-40a7-87fe-985f734b0647
function create_bar()
	
	vector = [0 for _ in 1:100]
	vector[50-10:50+10] .= 20
	return [RGB(x/100, x/100, x/100) for x in vector]
end

# ╔═╡ b8c53414-eec1-4645-a48a-aa93400a101f
create_bar()

# ╔═╡ 2a16ce29-70f6-4c8a-8b8d-75d6666a51e4
md"""
## Reducing the size of an image
"""

# ╔═╡ 6bf263e2-1843-432a-8073-a885fc4dd231
reduced_image = new_phil[1:10:end, 1:10:end]

# ╔═╡ 9bb2610d-50da-455b-9974-a25a764ae6c6
save("reduced_phil.png", reduced_image)

# ╔═╡ 09f24c1e-4094-42c8-8a87-b3a6451f7406
md"""
## Arrays
"""

# ╔═╡ ce2cca4b-5fcb-477e-ac8e-83bc39ade498
[1, 20, "hello"]

# ╔═╡ e049d59e-db10-4184-8133-78edc509daa5
[RGB(x, 0, 0) for x in 0:.1:1]

# ╔═╡ 7425cc6a-6b5d-4f45-b9bf-dc11bf8a8325
[RGB(red, green, 0) for red in 0:.1:1 for green in 0:.1:1]

# ╔═╡ 85d2026f-a5b2-478c-8680-e10fc2cb8e2b
[RGB(red, green, 0) for red in 0:.1:1, green in 0:.1:1]

# ╔═╡ Cell order:
# ╠═6f62ccca-a06f-11eb-3681-5de363807f78
# ╠═239240d6-aa3a-47e1-b6d7-01bfba9f1db6
# ╠═95c832b2-1669-48fb-9a79-3a78bf674d63
# ╠═1f47858d-48c0-4cba-80b9-d8f521da04d1
# ╠═1962c789-bde6-43bd-910c-0a5a3ae69bbf
# ╠═f7ec05aa-2470-4a78-afeb-a301ebc1931f
# ╠═c49ba928-1f22-4a69-9c5f-eb4da0e0edfe
# ╠═61d7c626-1c05-4522-a5bf-35e8547af8bf
# ╠═108dcd52-e7ec-4585-907f-d64150c7156b
# ╠═1398ff50-bdd8-4a7f-b05e-b22558147f37
# ╠═54b5ea2e-395a-44ca-b301-cd4155fc458a
# ╠═9c348636-7bd0-45f6-bdf5-926c27313e78
# ╠═f94df369-445c-49eb-8b7f-fd3da1915872
# ╠═b9785995-9da1-4fa8-a4f3-ac03c96dae48
# ╠═44710ae8-6558-4b87-af2b-726025441517
# ╠═2b425505-8910-4782-80b1-ce98442bd4d4
# ╠═9ff63b16-cc92-4b3c-b197-5427385df870
# ╠═cb3667da-175f-4b09-a1d3-4600392bc545
# ╠═c2db34c5-8f50-4dca-b857-d8833d366944
# ╠═4540acad-0e08-4cc4-b523-5fc9257c7a8b
# ╠═c9b0f7e0-a330-4e41-90df-144809912c3b
# ╠═cbe33d74-554a-4f01-ad88-65f1e86a6935
# ╠═24d672c1-ab80-4872-bba5-4942f5dfd2f5
# ╠═992a6d37-c779-46d9-a86d-6433812152c3
# ╠═2c314d20-2dc8-4ffe-8fef-6e915b7ec555
# ╠═26d8c359-d296-4c3c-9172-b00b29628318
# ╠═13de49f4-0bfe-4061-922d-61f9e48743a6
# ╠═47b3942c-3f54-49aa-a640-37aee25ba15f
# ╠═6642901b-e19d-4c52-adff-2fa0dd5efce7
# ╠═e23252ef-eecb-4068-b3d8-121194b7a4e5
# ╠═3ddcb149-5a4b-453a-bef0-980af79f1ad4
# ╠═dad9f88b-06c3-45a4-bfa7-2e25100339ed
# ╠═9abf35ad-8308-4c91-a5db-5daa8c3243ee
# ╠═bfbb9b7c-763a-4aa5-92d0-70fa5aefc124
# ╠═828b03f8-9290-45ae-aa85-f0ac43efadf6
# ╠═8b990bf0-f9a7-438a-aa62-970a3fda9b64
# ╠═24811842-4f45-4344-bfc2-821689e10c40
# ╠═224ff9ef-2f0a-4cec-b9af-5475f4bc8439
# ╟─26f91556-3d9c-47e0-8df8-6e15aca1ff7e
# ╠═44624703-7f91-40a7-87fe-985f734b0647
# ╠═b8c53414-eec1-4645-a48a-aa93400a101f
# ╟─2a16ce29-70f6-4c8a-8b8d-75d6666a51e4
# ╠═6bf263e2-1843-432a-8073-a885fc4dd231
# ╠═9bb2610d-50da-455b-9974-a25a764ae6c6
# ╟─09f24c1e-4094-42c8-8a87-b3a6451f7406
# ╠═ce2cca4b-5fcb-477e-ac8e-83bc39ade498
# ╠═e049d59e-db10-4184-8133-78edc509daa5
# ╠═7425cc6a-6b5d-4f45-b9bf-dc11bf8a8325
# ╠═85d2026f-a5b2-478c-8680-e10fc2cb8e2b
