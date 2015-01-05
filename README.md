# Seagull

Simple GUI library for Elixir language based on wxErlang.

## Usage

Add `:seagull, git: "https://github.com/stisa/seagull.git"` to your deps in your mix.exs, then `mix deps.get`.
Then you can try the example below, just copy paste the code in a `.ex` file and do:

```
mix compile && iex -S mix
YourExFile.start
```

### Window with one button

    defmodule A do
      import Widget
      def start() do
        f=frame id: :main_frame, title: "Frame title" do
          button id: :button, label: "I am a button"
        end
        WindowProcess.spawn_gui f
      end
    end

### More examples
See branch "examples".

## Examples
To run the examples in the branch "examples" do:

```
mix compile
iex -S mix
Demo./*moduleName*/.start
```

for example, to start the Button demo, do:

```
mix compile
iex -S mix
Demo.Button.start
```



