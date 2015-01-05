defmodule Demo.PID do
  
  import Widget
  import Seagull

  def start() do
    pidA=spawn fn()->f(:A)end
    pidB=spawn fn()->f(:B)end
    pidC=spawn fn()->f(:C)end
    f=frame id: :f, react: [:close] do
      box :vertical do
        box :horizontal, children_pid: pidA do
          button id: :A, label: "A", react: [:click]
          button id: :B, label: "B", pid: pidB, react: [:click]
        end
        box :horizontal do
          button id: :C, label: "C", pid: pidC, react: [:click]
          button id: :D, label: "D", react: [:click]
        end
      end
    end

    gui_pid=WindowProcess.spawn_gui f

    IO.puts "Main process: #{pid_to_binary(self)}"
    IO.puts "GUI process:  #{pid_to_binary(gui_pid)}"

    reaction gui_pid, [pidA, pidB, pidC]

  end

  def reaction(gui_pid, pids) do
    receive_event do
      from pid: ^gui_pid do
        from widget: :f do
          :close->
            send gui_pid, :destroy
            Enum.each pids, fn(pid)-> send pid, :end end
        end
        from widget: :D do 
          :click->
            IO.puts "#{pid_to_binary(self)}: Clicked D."
            reaction gui_pid, pids
        end
      end
    end

  end

  def f(widget) do
    receive_event do
      from pid: _pid do
        from widget: ^widget do 
          :click->
            IO.puts "#{pid_to_binary(self)}: Clicked #{Atom.to_string(widget)}."
            f widget
        end
      end
    message do
      :end->nil
    end
    end
  end

end
