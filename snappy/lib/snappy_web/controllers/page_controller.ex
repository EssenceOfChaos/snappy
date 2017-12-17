defmodule SnappyWeb.PageController do
  use SnappyWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
