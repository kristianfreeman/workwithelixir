defmodule Workwithelixir.PageController do
  use Timex
  use Workwithelixir.Web, :controller
  alias Workwithelixir.JobModule

  def index(conn, _params) do
    render conn, "index.html"
  end

  def about(conn, _params) do
    render conn, "about.html"
  end

  def elixirconf(conn, _params) do
    hide_search = true
    render conn, "elixirconf.html"
  end

  def authenticated(conn, _params) do
    render conn, "index.html"
  end

  def feed(conn, _params) do
    {:ok, date} = Timex.format(DateTime.now(), "{RFC822}")
    channel = RSS.channel(
      "Work With Elixir",
      "https://workwithelixir.com",
      "Find the best Elixir, Phoenix and Erlang jobs - full-time, part-time, on-location, or working remote from around the world.",
      date,
      "en-us"
    )

    items = JobModule.retrieve_jobs() |> Enum.map(fn job ->
      {:ok, date} = Timex.to_datetime(Ecto.DateTime.to_erl(job.posted))
      |> Timex.format("{RFC822}")

      {:safe, title} = Phoenix.HTML.html_escape("#{job.title} - #{job.company}")
      {:safe, description} = Phoenix.HTML.html_escape(job.job_description)
      {:safe, url} = Phoenix.HTML.html_escape(job.apply_url || job.company_url)
      guid = "https://workwithelixir.com/jobs/#{job.id}"

      RSS.item(
        title,
        description,
        date,
        url,
        guid
      )
    end)

    feed = RSS.feed(channel, items)

    render conn, "feed.xml", feed: feed
  end
end
