defmodule Scrape do
  alias Scrape.Fetch
  alias Scrape.Feed
  alias Scrape.Website
  alias Scrape.Article

  def feed(url, type \\ :not_minimal, httpoison_opts \\ []) do
    html = Fetch.run(url, httpoison_opts)
    if type == :minimal do
      Feed.parse_minimal(html)
    else
      Feed.parse(html)
    end
  end

  def website(url, httpoison_opts \\ []) do
    url
    |> Fetch.run(httpoison_opts)
    |> Website.parse(url)
  end

  def article(url, httpoison_opts \\ []) do
    html = Fetch.run url, httpoison_opts
    website = Website.parse(html, url)
    Article.parse(website, html)
  end

end
