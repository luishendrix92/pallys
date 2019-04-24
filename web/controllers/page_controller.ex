defmodule Pallys.PageController do
  use Pallys.Web, :controller

  def index(conn, _params) do
    render conn, "index.html", whereami: "Home"
  end
end
