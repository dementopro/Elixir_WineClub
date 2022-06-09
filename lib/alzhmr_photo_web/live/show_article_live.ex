defmodule AlzhmrPhotoWeb.ShowArticleLive do
  use AlzhmrPhotoWeb, :live_view

  @topic "articles"

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    AlzhmrPhotoWeb.Endpoint.subscribe(@topic)

    {:ok, assign_socket(socket, id)}
  end

  @impl true
  def handle_info(%{event: "update"}, socket) do
    id = socket.assigns.article.id

    {:noreply, assign_socket(socket, id), temporary_assigns: [article: nil]}
  end

  defp assign_socket(socket, id) do
    case AlzhmrPhoto.get_article(id) do
      {:ok, article} ->
        socket
        |> assign(:page_title, article.title)
        |> assign(:article, article)
        |> put_flash(:error, nil)

      _ ->
        socket
        |> assign(:page_title, "Wine Detail")
        |> assign(:article, nil)
        |> put_flash(:error, "Error fetching data")
    end
  end
end
