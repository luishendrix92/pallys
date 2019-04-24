defmodule Pallys.Hirezapi do
  use Task

  def start_link() do
    Task.start_link(&renew_session/0)
  end

  def renew_session() do
    Exrez.Session.create(:paladins_pc)
    
    receive do
      # Ask for new Hi-Rez sessions every 15 minutes
      after 900_000 -> renew_session()
    end
  end
end
