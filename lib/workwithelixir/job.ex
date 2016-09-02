defmodule Workwithelixir.JobModule do
  import Ecto.Query, only: [from: 2]

  alias Workwithelixir.Job
  alias Workwithelixir.Repo

  def all_jobs_query() do
    from j in Job,
      where: j.status == "Live",
      select: j,
      order_by: [desc: :posted]
  end

  def retrieve_jobs() do
    Repo.all(all_jobs_query())
  end
end
