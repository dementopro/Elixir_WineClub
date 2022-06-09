defmodule AlzhmrPhotoWeb.PageLive do
  use AlzhmrPhotoWeb, :live_view

  alias AlzhmrPhotoWeb.LiveEncoder

  @topic "contents"

  @impl true
  def mount(_params, _session, socket) do
    AlzhmrPhotoWeb.Endpoint.subscribe(@topic)

    {:ok, assign_socket(socket), temporary_assigns: [contents: []]}
  end

  @impl true
  def handle_info(%{event: "update"}, socket) do
    {:noreply, assign_socket(socket)}
  end

  def render_section(%{type: "hero"} = content) do
  #  IO.inspect(label: "hero", content: content)
    Phoenix.View.render(AlzhmrPhotoWeb.PageView, "hero.html", content: content)
  end

  def render_section(%{type: "text_and_image"} = content) do
    Phoenix.View.render(AlzhmrPhotoWeb.PageView, "text_and_image.html", content: content)
  end

  def render_section(%{features: content}) do
    Phoenix.View.render(AlzhmrPhotoWeb.PageView, "features.html", content: content)
  end

  def render_section(_), do: ""

  defp assign_socket(socket) do
    case fetch_contents() do
      {:ok, contents} ->
        socket
        |> assign(:page_title, "Home")
        |> assign(:contents, contents)
        |> put_flash(:error, nil)

      _ ->
        socket
        |> assign(:page_title, "Home")
        |> assign(:contents, nil)
        |> put_flash(:error, "Error fetching data")
    end
  end

  defp fetch_contents do
    with {:ok, contents} <- AlzhmrPhoto.contents() do
      contents =
        contents
        |> Enum.sort_by(& &1.position)
        |> LiveEncoder.contents()

      {:ok, contents}
    end
  end
end
