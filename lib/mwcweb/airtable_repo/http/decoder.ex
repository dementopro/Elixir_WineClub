defmodule Mwcweb.AirtableRepo.Http.Decoder do
  @moduledoc false

  alias Mwcweb.{Article, Content, Blogpost}

  def decode(response) when is_list(response) do
    Enum.map(response, &decode/1)
  end

  def decode(%{
        "id" => id,
        "fields" =>
          %{
            "slug" => slug
          } = fields
      }) do
    %Article{
      id: id,
      slug: slug,
      title: Map.get(fields, "title", ""),
      description: Map.get(fields, "description", ""),
      # vintage: Map.get(fields, "vintage", ""),
      image: decode_image(Map.get(fields, "image")),
      content: Map.get(fields, "content", ""),
      author: Map.get(fields, "author", ""),
      published_at: Date.from_iso8601!(Map.get(fields, "published_at"))
    }
  end



  def decode(%{
        "fields" =>
          %{
            "type" => type
          } = fields
      }) do
    %Content{
      id: Map.get(fields, "id", ""),
      position: Map.get(fields, "position", ""),
      type: type,
      title: Map.get(fields, "title", ""),
      content: Map.get(fields, "content", ""),
      image: decode_image(Map.get(fields, "image", "")),
      styles: Map.get(fields, "styles", ""),
      url: Map.get(fields, "url", "")
    }
  end

  def decode(%{
    "id" => id,
        "fields" =>
          %{
            "bslug" => bslug
          } = fields
      }) do
%Blogpost{
  id: id,
  bslug: bslug,
  disporder: Map.get(fields, "disporder", ""),
  title: Map.get(fields, "title", ""),
  content: Map.get(fields, "content", ""),
  summary: Map.get(fields, "summary", ""),
  published_at: Map.get(fields, "published_at", ""),
  image: decode_image(Map.get(fields, "image", "")),
  blogcover_image: decode_image(Map.get(fields, "blogcover_image", "")),

}
end


  defp decode_image([%{"url" => url}]), do: url
  defp decode_image(_), do: ""
end
