local function docs(data, args)
	local slug
	if args then
		slug = args[1]
	end

	if slug == "sector-id" then
		print("Sector ID")
		local sector_id = GetCurrentSectorid()
		print("Number: "..tostring((type(sector_id) == "number")))
		print("Example: "..tostring(sector_id))
	elseif slug == "doc-id" then
		print("That was an example. Instead of doc-id, use something from the list printed when you type:")
		print("/doc help")
	else
		print("Documentation available for:")
		print(string.format("* %s", "sector-id"))

		print("")
		print("To see the documentation for doc-id (for example), type:")
		print("/docs doc-id")

		if slug and slug ~= "help" then
			print(string.format("Error: no documentation for %s", slug))
		end
	end
end
RegisterUserCommand("docs", docs)
