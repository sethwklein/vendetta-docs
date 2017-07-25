#!/usr/bin/env lua

local preamble = [[
local function docs(data, args)
	local slug
	if args then
		slug = args[1]
	end

]]

local example = [[if slug == "doc-id" then
		print("That was an example. Instead of doc-id, use something from the list printed when you type:")
		print("/doc help")
	else
		print("Documentation available for:")
]]

local doc_listing = [[
		print(string.format("* %%s", %q))
]]

local postamble = [[

		print("")
		print("To see the documentation for doc-id (for example), type:")
		print("/docs doc-id")

		if slug and slug ~= "help" then
			print(string.format("Error: no documentation for %s", slug))
		end
	end
end
RegisterUserCommand("docs", docs)
]]

local function toslug(s)
	s = string.lower(s)
	s = string.gsub(s, " ", "-")
	s = string.gsub(s, "[^a-zA-z-]", "")
	return s
end

local function is_doc_header(line)
	return string.sub(line, 1, #"### ") == "### "
end

local function main()
	local next
	local line

	do
		local file, err = io.open("README.md")
		if err ~= nil then
			return err
		end
		-- garbage collection or the operating system will close it

		next = file:lines()
	end

	while true do
		line = next()
		if line == nil then
			return "no documentation found"
		end
		if line == "## Documentation" then
			break
		end
	end

	local output, err = io.open("main.lua", "w")
	if err ~= nil then
		return err
	end

	output:write(preamble)

	local state
	local got_document = 1
	local finding_code = 2
	local printing_code = 3
	local finished_document = 4

	while true do
		line = next()
		if line == nil then
			-- normal exit, no document
			state = nil
			break
		elseif is_doc_header(line) then
			state = got_document
			break
		end
	end

	local docs = {}

	local title
	local slug

	while state do
		if state == got_document then
			title = string.sub(line, #"### " + 1)
			slug = toslug(title)

			output:write(string.format("\tif slug == %q then\n", slug))
			output:write(string.format("\t\tprint(%q)\n", title))

			state = finding_code
		elseif state == finding_code then
			line = next()
			if line == nil then
				state = finished_document
			elseif is_doc_header(line) then
				state = finished_document
			elseif line == "```" then
				state = printing_code
			end
		elseif state == printing_code then
			line = next()
			if line == nil then
				return "unclosed fenced code block"
			elseif line == "```" then
				state = finding_code
			else
				output:write("\t\t")
				output:write(line)
				output:write("\n")
			end
		elseif state == finished_document then
			output:write(string.format("\telse"))
			docs[#docs+1] = slug
			if line then
				state = got_document
			else
				state = nil
			end
		end
	end

	output:write(example)

	for i = 1, #docs do
		output:write(string.format(doc_listing, docs[i]))
	end

	output:write(postamble)

	output:close()
end

local err = main()

if err == nil then
	os.exit(0)
end

print("Error: "..err)
os.exit(1)
