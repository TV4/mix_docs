# MixDocs

A mix task to generate Aglio documentation

## Installation

Needs Aglio to work
`npm install -g aglio`

Add dependency to your `mix.exs`
```elixir
def deps do
  [
    {:mix_docs, "~> 0.1.0"}
  ]
end
```

Create the blueprint file
`mkdir docs`
`touch blueprint.apib`

Documentation of aglio can be found here
https://github.com/danielgtaylor/aglio

## Run
Generate documentation
`mix docs`

Generate documentation everytime blueprint.apib changes
`mix docs --watch`
