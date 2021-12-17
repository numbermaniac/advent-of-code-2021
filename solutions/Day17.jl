function part1and2()
	# Input file is small enough that you can just enter it manually instead of parsing the file
	xmin = 257
	xmax = 286
	ymin = -101
	ymax = -57

	highestheight = 0
	validvelocities = 0

	for xvel in 1:xmax
		for yvel in ymin:100
			x, y = 0, 0
			xvelcur = xvel
			yvelcur = yvel
			highesty = 0
			success = true
			while !(xmin <= x <= xmax && ymin <= y <= ymax)
				x += xvelcur
				y += yvelcur
				if xvelcur > 0
					xvelcur -= 1
				elseif xvelcur < 0
					xvelcur += 1
				end
				yvelcur -= 1

				if y > highesty
					highesty = y
				end

				if x > xmax || y < ymin
					success = false
					break
				end
			end

			if success
				if highesty > highestheight
					highestheight = highesty
				end
				validvelocities += 1
			end
		end
	end

	return (highestheight, validvelocities)
end

println(part1and2())