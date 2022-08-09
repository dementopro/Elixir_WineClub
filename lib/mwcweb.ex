defmodule Mwcweb do
  @moduledoc """
  Mwcweb keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  defdelegate articles, to: Mwcweb.AirtableRepo
  defdelegate blogposts, to: Mwcweb.AirtableRepo
  defdelegate contents, to: Mwcweb.AirtableRepo


  defdelegate get_article(id), to: Mwcweb.AirtableRepo
  defdelegate get_blogpost(id), to: Mwcweb.AirtableRepo

end
