defmodule AlzhmrPhoto do
  @moduledoc """
  AlzhmrPhoto keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  defdelegate articles, to: AlzhmrPhoto.AirtableRepo

  defdelegate contents, to: AlzhmrPhoto.AirtableRepo


  defdelegate get_article(id), to: AlzhmrPhoto.AirtableRepo

end
