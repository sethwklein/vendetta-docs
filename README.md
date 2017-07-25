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
print("Number: "..tostring((type(sector_id) == "number")))
print("Example: "..tostring(sector_id))
```
