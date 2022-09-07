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
          image1: String.t(),
          image2: String.t(),
          image3: String.t(),
          image4: String.t(),
          blogcover_image: String.t(),
         # author: String.t(),
          published_at: Date.t()
        }

  defstruct [:id, :bslug, :title, :disporder, :description, :summary, :image, :image1, :image2, :image3, :image4, :blogcover_image, :content, :published_at]
end
