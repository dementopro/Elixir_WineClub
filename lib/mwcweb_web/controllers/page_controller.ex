defmodule MwcwebWeb.PageController do
  use MwcwebWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def profile(conn, _params) do
    render(conn, "profile.html")
  end

  def products(conn, _params) do
    render(conn, "products.html")
  end

  def wines(conn, _params) do
    render(conn, "wines.html")
  end
end
