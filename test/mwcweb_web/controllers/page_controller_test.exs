defmodule MwcwebWeb.PageControllerTest do
  use MwcwebWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Premium private label wine"
  end

  test "GET Wine Futures", %{conn: conn} do
    conn = get(conn, "/collection/wine-futures")
    assert html_response(conn, 200) =~ "<h6>wine futures page</h6>"
  end

  test "GET Bottle Shop", %{conn: conn} do
    conn = get(conn, "/collection/bottle-shop")
    assert html_response(conn, 200) =~ "<h6>bottle shop page</h6>"
  end


end
