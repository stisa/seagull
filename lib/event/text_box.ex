defmodule Event.TextBox do
  require Event

   @events [
      update: :command_text_updated,
      enter_pressed: :command_text_enter,
    ]

  def get_events() do
    @events
  end

  Event.generate_function_react()
  Event.generate_function_dont_react()

  for {sg, wx} <- @events do
    def translate(_wxid, _wxobject, id, unquote(sg), {_, unquote(wx), value, _, _}, window) do
      widget=Keyword.get window, id
      pid=Keyword.get widget, :pid
      send pid, [self, id, unquote(sg), to_string(value)]
      true
    end
  end
  def translate(_wxid, _wxobject, _id, _event_type, _event, _window) do
    false
  end

end
