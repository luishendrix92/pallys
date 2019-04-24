defmodule Pallys.PalbotController do
  use Pallys.Web, :controller
  alias Exrez.Paladins
  alias Exrez.Hirez
  alias Pallys.Palbot

  plug :put_layout, "bot.html"

  def index(conn, _params) do
    render conn, "index.html", whereami: "Hell"
  end
  
  def rank(conn, %{"player" => player}) do
    case Hirez.player(:paladins_pc, player) do
      {:ok, []} -> text conn, "Player doesn't exist in Paladins PC!"
      {:ok, player_info} -> text conn, Palbot.player_rank(player_info)
      {:err, msg} -> text conn, msg
    end
  end

  def regions(conn, %{"player" => player}) do
    case Hirez.match_history(:paladins_pc, player) do
      {:ok, []} -> text conn, "Wrong player name '#{player}' or no matches played yet!"
      {:ok, history} -> text conn, Palbot.regions(history)
      {:err, msg} -> text conn, msg
    end
  end

  def mains(conn, %{"player" => player}) do
    case Hirez.match_history(:paladins_pc, player) do
      {:ok, []} -> text conn, "Wrong player name '#{player}' or no matches played yet!"
      {:ok, history} -> text conn, Palbot.mains(history)
      {:err, msg} -> text conn, msg
    end
  end

  # def champions(conn, _params) do
  #   case Paladins.champions(:paladins_pc) do
  #     {:ok, champs} -> json conn, champs
  #     {:err, msg} -> send_resp(conn, 404, msg)
  #   end
  # end
end
