defmodule MwcwebWeb.PageLive do
  use MwcwebWeb, :live_view

  alias MwcwebWeb.LiveEncoder

  @topic "contents"

  @impl  Phoenix.LiveView
  def mount(_params, _session, socket) do
    MwcwebWeb.Endpoint.subscribe(@topic)

    {:ok, assign_socket(socket), temporary_assigns: [contents: []]}
  end

  @impl  Phoenix.LiveView
  def handle_info(%{event: "update"}, socket) do
    {:noreply, assign_socket(socket)}
  end

  def render_section(%{type: "hero"} = content) do
  #  IO.inspect(label: "hero", content: content)
    Phoenix.View.render(MwcwebWeb.PageView, "hero.html", content: content)
  end

  def render_section(%{type: "text_and_image"} = content) do
    Phoenix.View.render(MwcwebWeb.PageView, "text_and_image.html", content: content)
  end

  # def render_section(%{type: "wine_collection"} = content) do
  #   Phoenix.View.render(MwcwebWeb.PageView, "collection.html", content: content)
  # end

  def render_section(_), do: ""

  defp assign_socket(socket) do
    case fetch_contents() do
      {:ok, contents} ->
        socket
        |> assign(:page_title, "MWC Home")
        |> assign(:contents, contents)
        |> put_flash(:error, nil)

      _ ->
        socket
        |> assign(:page_title, "MWC Home")
        |> assign(:contents, nil)
        |> put_flash(:error, "Error fetching data")
    end
  end

  defp fetch_contents do
    with {:ok, contents} <- Mwcweb.contents() do
      contents =
        contents
        |> Enum.sort_by(& &1.position)
        |> LiveEncoder.contents()

      {:ok, contents}
    end
  end
end
