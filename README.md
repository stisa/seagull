# Seagull

Simple GUI library for Elixir language based on wxErlang.

## Examples
To run the examples in lib/demo do:

```
mix run -e Demo./*moduleName*/
iex -S mix
Demo./*moduleName*/.start
```

for example, to start the Button demo, do:

```
mix run -e Demo.Button
iex -S mix
Demo.Button.start
```


### Window with one button

    defmodule A do
      import Widget
      def start() do
        f=frame id: :main_frame, title: "Frame title" do
          button id: :button
        end
        WindowProcess.spawn_gui f
      end
    end

### Window with two buttons

    defmodule B do
      import Widget
      def start() do
        f=frame id: :main_frame do
          box :vertical do
            button id: :button1, label: "First Button"
            button id: :button2, label: "Second Button"
          end
        end
        WindowProcess.spawn_gui f
      end
    end

### Window with button that counts clicks

    defmodule C do
      
      import Seagull
      import Widget
      
      def start() do
        f=frame id: :main_frame, react: [:close] do
          button id: :button, label: "Number of clicks: 0.", react: [:click]
        end
        pid=WindowProcess.spawn_gui f
        reaction pid
      end
      
      def reaction(pid) do
        continue=true
        receive_event do
          from pid: ^pid do
            from widget: :button do
              :click->
                label=send pid, :button, :get_label
                count=Regex.run(%r/[0-9]+/, label) |> List.first |> binary_to_integer
                count=count+1
                label=Regex.replace %r/([0-9]+)/, label, integer_to_binary(count)
                send pid, :button, :set_label, label
            end
            from widget: :main_frame do
              :close->
                send pid, :destroy
                continue=false
            end
          end
        end
        if continue, do: reaction(pid)
      end
      
    end

### More examples
See lib/demo.
