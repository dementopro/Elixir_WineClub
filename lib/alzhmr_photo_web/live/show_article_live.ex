defmodule AlzhmrPhotoWeb.ShowArticleLive do
  use AlzhmrPhotoWeb, :live_view

  @topic "articles"

  @impl  Phoenix.LiveView
  def mount(%{"id" => id}, _session, socket) do
    AlzhmrPhotoWeb.Endpoint.subscribe(@topic)

    {:ok, assign_socket(socket, id)}
  end

  @impl  Phoenix.LiveView
  def handle_info(%{event: "update"}, socket) do
    id = socket.assigns.article.id

    {:noreply, assign_socket(socket, id), temporary_assigns: [article: nil]}
  end

  defp assign_socket(socket, id) do
    IO.puts "scott look here"
    IO.inspect(id)
    case AlzhmrPhoto.get_article(id) do

      {:ok, article} ->
        socket
        |> assign(:page_title, article.title)
        |> assign(:article, article)
        |> put_flash(:error, nil)

      _ ->
        socket
        |> assign(:page_title, "Photo Detail")
        |> assign(:article, nil)
        |> put_flash(:error, "Error fetching data")
    end
  end
end
