defmodule MwcwebWeb.BlogpostsLive do
  use MwcwebWeb, :live_view

  alias MwcwebWeb.LiveEncoder

  @topic "blogposts"

  @impl  Phoenix.LiveView
  def mount(_params, _session, socket) do
    MwcwebWeb.Endpoint.subscribe(@topic)

    {:ok, assign_socket(socket), temporary_assigns: [blogposts: []]}
  end

  @impl  Phoenix.LiveView
  def handle_info(%{event: "update"}, socket) do
    {:noreply, assign_socket(socket)}
  end

  def render_blogpost(socket, %{id: _id, bslug: _bslug} = blogpost,counter ) do
    Phoenix.View.render(MwcwebWeb.PageView, "blogpost.html", socket: socket, blogpost: blogpost , counter: counter)
  end

  defp assign_socket(socket) do
    case fetch_blogposts() do
      {:ok, blogposts} ->
        socket
        |> assign(:page_title, "Blogpost Detail")
        |> assign(:blogposts, blogposts)
        |> put_flash(:error, nil)

      _ ->
        socket
        |> assign(:page_title, "Blogpost Detail")
        |> assign(:articles, nil)
        |> put_flash(:error, "Error fetching data")
    end
  end

  defp fetch_blogposts do
    with {:ok, blogposts} <- Mwcweb.blogposts() do
      blogposts
      |> Enum.sort_by(& &1.published_at)
      |> LiveEncoder.blogposts()

      {:ok, blogposts}
    end
  end
end
