defmodule MwcwebWeb.ShowBlogpostLive do
  use MwcwebWeb, :live_view

  @topic "blogposts"

  @impl  Phoenix.LiveView
  def mount(%{"id" => id}, _session, socket) do
    MwcwebWeb.Endpoint.subscribe(@topic)

    {:ok, assign_socket(socket, id)}
  end

  @impl  Phoenix.LiveView
  def handle_info(%{event: "update"}, socket) do
    id = socket.assigns.blogpost.id

    {:noreply, assign_socket(socket, id), temporary_assigns: [blogpost: nil]}
  end

  defp assign_socket(socket, id) do
    IO.puts "scott look here"
    IO.inspect(id)
    case Mwcweb.get_blogpost(id) do

      {:ok, blogpost} ->
        socket
        |> assign(:page_title, blogpost.title)
        |> assign(:blogpost, blogpost)
        |> put_flash(:error, nil)

      _ ->
        socket
        |> assign(:page_title, "Blogpost Details")
        |> assign(:blogpost, nil)
        |> put_flash(:error, "Error fetching data")
    end
  end
end
