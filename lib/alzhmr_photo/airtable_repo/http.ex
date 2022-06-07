defmodule AlzhmrPhoto.AirtableRepo.Http do
  @moduledoc false

  alias __MODULE__.Decoder
  alias AlzhmrPhoto.{Article, Content, AirtableRepo}
  alias Services.Airtable

  @behaviour AirtableRepo

  @articles_table "articles"
  @contents_table "contents"


  @impl AirtableRepo
  def all(Article), do: do_all(@articles_table)
  def all(Content), do: do_all(@contents_table)


  @impl AirtableRepo
  def get(Article, id), do: do_get(@articles_table, id)
  def get(Content, id), do: do_get(@contents_table, id)


  defp do_all(table) do
    case Airtable.all(table) do
      {:ok, %{"records" => records}} ->
        {:ok, Decoder.decode(records)}

      {:error, 404} ->
        {:error, :not_found}

      other ->
        other
    end
  end

  defp do_get(table, id) do
    case Airtable.get(table, id) do
      {:ok, response} ->
        {:ok, Decoder.decode(response)}

      {:error, 404} ->
        {:error, :not_found}

      other ->
        other
    end
  end
end
