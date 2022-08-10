defmodule MwcwebWeb.LiveEncoder do
  @moduledoc false

  alias Mwcweb.{Article, Content, Blogpost}

  def contents(items) when is_list(items) do
    {features, rest} =
      items
      |> Enum.map(&encode/1)
      |> Enum.split_with(&(&1.type == "feature"))

    rest
    |> Enum.concat([%{features: features}])
    |> List.flatten()
  end

  def articles(articles) do
    Enum.map(articles, &encode/1)
  end

  def blogposts(blogposts) do
    Enum.map(blogposts, &encode/1)
  end


  def encode(%Content{} = content) do
    Map.take(content, [:id, :type, :title, :content, :image, :styles, :url])
  end

  def encode(%Blogpost{} = blogpost) do
    Map.take(blogpost, [:id, :bslug, :disporder, :description, :title, :summary, :content, :blogcover_image, :image , :published_at])
  end


  def encode(%Article{} = article) do
    Map.take(article, [:id, :slug, :title, :description,  :image, :author,  :published_at])
  end


end
