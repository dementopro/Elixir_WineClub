defmodule Mwcweb.Article.Cache do
  @moduledoc """
  Article cache
  """

  alias Mwcweb.{AirtableRepo, AirtableRepo.Cache}

  @behaviour Cache

  @topic "articles"

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :worker,
      restart: :permanent,
      shutdown: 500
    }
  end

  @impl Cache
  def table_name, do: :wines

  @impl Cache
  def start_link(_args) do
    GenServer.start_link(Cache, __MODULE__, name: __MODULE__)
  end

  @impl Cache
  def fetch_fn, do: fn -> AirtableRepo.articles(true) end

  @impl Cache
  def topic, do: @topic
end
