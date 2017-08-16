local indent = ""

local function header(text)
	print(text..":")
	indent = "\t"
end

local function is_number(v)
	print(indent.."Number: "..tostring((type(v) == "number")))
end

local function is_string(v)
	print(indent.."String: "..tostring((type(v) == "string")))
end

local function is_item_id(v)
	local is = type(v) == "number" and GetInventoryItemName(v) ~= nil
	print(indent.."Item ID (number): "..tostring(is))
end

-- item_classes duplicates data, but attempts at (presumably) security
-- through obscurity prevent the global scope searches that would avoid
-- the duplication.
local item_classes = {
	[0] = "CLASSTYPE_GENERIC",
	[1] = "CLASSTYPE_SHIP",
	[2] = "CLASSTYPE_ADDON",
	[3] = "CLASSTYPE_FLAG",
	[4] = "CLASSTYPE_STORAGE",
	[5] = "CLASSTYPE_MISSION",
}

local function is_item_class(v)
	local is = type(v) == "number" and item_classes[v] ~= nil
	print(indent.."Item class (number): "..tostring(is))
end

local item_subtypes = {
	[0] = "light weapon or ship",
	[1] = "heavy weapon",
	[3] = "engine",
	[4] = "battery",
	[10] = "trade goods",
}

local function is_item_subtype(v)
	print(indent.."Item subtype (number): "..tostring((type(v) == "number")).." (probably)")
end

local function docs(data, args)
	local slug
	if args then
		slug = args[1]
	end

	if slug == "sector-id" then
		print("Sector ID")
		local sector_id = GetCurrentSectorid()
		is_number(sector_id)
		print("Sample: "..tostring(sector_id))
		indent = ""
	elseif slug == "inventory" then
		print("Inventory")
		local iterator = PlayerInventoryPairs()
		local item_id, duplicate = iterator()
		is_item_id(item_id)
		print("Sample: "..tostring(item_id))
		print("Key and value are the same: "..tostring(item_id == duplicate))
		local items = {}
		for item_id, _ in PlayerInventoryPairs() do
		    table.insert(items, item_id)
		end
		print("You have "..#items.." items")
		indent = ""
	elseif slug == "item-information" then
		print("Item Information")
		local item_id, _ = PlayerInventoryPairs()()
		local icon_path, name, quantity, metric_tons, short_description,
		    long_description, strange_description, containing_item_id, item_class,
		    item_subtype = GetInventoryItemInfo(item_id)

		header("Icon path")
		is_string(icon_path)
		print("\tSample: "..string.format("%q", icon_path))

		header("Name")
		is_string(name)
		print("\tSample: "..string.format("%q", name))
		header("Quantity")
		is_number(quantity)
		print("\tSample: "..tostring(quantity))

		header("Metric tons")
		is_number(metric_tons)
		print("\tSample: "..tostring(metric_tons)..
		    " ("..tostring(math.round(metric_tons*1000)).."kg)")

		header("Short description")
		is_string(short_description)
		print("\tSample: "..string.format("%q", short_description))

		header("Long description")
		is_string(long_description)
		print("\tSample: "..string.format("%q", long_description))

		header("Strange description")
		is_string(strange_description)
		print("\tSample: "..string.format("%q", strange_description))

		header("Containing item ID")
		is_item_id(containing_item_id)
		print("\tSample: "..tostring(containing_item_id)..
		    " ("..tostring(GetInventoryItemName(containing_item_id))..")")

		header("Item class")
		is_item_class(item_class)
		print("\tSample: "..tostring(item_class)..
		    " ("..item_classes[item_class]..")")

		header("Item subtype")
		is_item_subtype(item_subtype)
		print("\tSample: "..tostring(item_subtype)..
		    " ("..item_subtypes[item_subtype]..")")
		indent = ""
	elseif slug == "item-name" then
		print("Item Name")
		local item_id, _ = PlayerInventoryPairs()()
		local name = GetInventoryItemName(item_id)
		is_string(name)
		print("\tSample: "..string.format("%q", name))
		indent = ""
	elseif slug == "doc-id" then
		print("That was an example. Instead of doc-id, try something from the list printed when you type:")
		print("/doc help")
	else
		print("Documentation available for:")
		print(string.format("* %s", "sector-id"))
		print(string.format("* %s", "inventory"))
		print(string.format("* %s", "item-information"))
		print(string.format("* %s", "item-name"))

		print("")
		print("To see the documentation for doc-id (for example), type:")
		print("/docs doc-id")

		if slug and slug ~= "help" then
			print(string.format("Error: no documentation for %s", slug))
		end
	end
end
RegisterUserCommand("docs", docs)
