# blogpost cms
defmodule Mwcweb.Blogpost do
  alias __MODULE__

  @type t :: %Blogpost{
          id: String.t(),
          bslug: String.t(),
          disporder: String.t(),
          title: String.t(),
          description: String.t(),
          summary: String.t(),
          image: String.t(),
          content: String.t(),
         # author: String.t(),
          published_at: Date.t()
        }

  defstruct [:id, :bslug, :title, :disporder, :description, :summary, :image, :content, :published_at]
end
