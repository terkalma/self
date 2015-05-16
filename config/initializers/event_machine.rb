#
# ensuring whe have a running +EventMachine+
#
def ensure_em
  unless EventMachine.reactor_running? && EventMachine.reactor_thread.alive?

    if EventMachine.reactor_running?
      EventMachine.stop_event_loop
      EventMachine.release_machine
      EventMachine.instance_variable_set '@reactor_running', false
    end

    Thread.new { EventMachine.run }
  end
end