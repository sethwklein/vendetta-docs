# Vendetta Plugin Documentation

Vendetta Plugin Documentation is unofficial documentation for developing
plugins for [Vendetta Online](https://vendetta-online.com/).

In a somewhat literate programming style, this document is automatically
transformed into a plugin for running and testing itself. To try it,
install this folder like any other plugin (see below) and type `/docs help`
in Vendetta. To make changes, see [Contributing](#contributing).

## Installing

I recommend cloning this into your Vendetta plugins folder because then when
you have something to contribute, you'll already have taken the first step,
but if Git and GitHub are foreign to you, or for some other reason....

Scroll up to the green "Clone or download" button above, click it, click
"Download ZIP", and install like usual for Vendetta plugins.

## Contributing

### Building

`main.lua` is generated from this file using `generate.lua`.

On MacOS do:

```
brew install lua
./generate.lua
```

If you use something besides MacOS, you'll have to figure it out yourself,
but we'd love a pull request when you get it figured out.

Even though plugins must use an older version, `generate.lua` works with a
more recent version of Lua, 5.2.4 as of this writing. This is so you
don't have to have so many versions of Lua installed if you do Lua development
on other, more assiduously updated projects.

### Writing

Get [Grip](https://github.com/joeyespo/grip). Seriously, it's awesome.

The format is [GitHub](https://help.github.com/articles/basic-writing-and-formatting-syntax/)
[Flavored](https://help.github.com/articles/working-with-advanced-formatting/)
[Markdown](https://help.github.com/articles/working-with-advanced-formatting/://help.github.com/categories/writing-on-github/).

This is documentation through sample code. That may be weird, but it's machine
checkable and precise, both useful things in programming.

The sample code shouldn't be thorough tests. It should be limited to things
one might not figure out from function names and such.

Sometimes it may be worth adding a usage block, either for the benefit of
people who don't know Lua very well or for things with odd usage.

### Pull Requests

* Make a branch just for your change so you don't accidentally add things to
    the pull request.
* Add a commit adding you to the `AUTHORS.txt` file.
* Do the normal GitHub thing.
* Watch for comments on your pull request. Orphans are less likely to make it,
    so don't abandon your babies!

## Documentation

### Sector ID

```
local sector_id = GetCurrentSectorid()
is_number(sector_id)
print("Sample: "..tostring(sector_id))
```

### Inventory

```
local iterator = PlayerInventoryPairs()
local item_id, duplicate = iterator()
is_item_id(item_id)
print("Sample: "..tostring(item_id))
print("Key and value are the same: "..tostring(item_id == duplicate))
```

[Ancient texts](http://www.vo-wiki.com/racecar2/index.php/API_PlayerInventoryPairs)
say `PlayerInventoryPairs` used to provide the item ID and a table of
information about the item. This may explain its strange design.

Usage:

```
local items = {}
for item_id, _ in PlayerInventoryPairs() do
    table.insert(items, item_id)
end
print("You have "..#items.." items")
```

### Item Information

```
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
```
