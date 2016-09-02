defmodule Workwithelixir.Repo.Migrations.AddIndexesToJob do
  use Ecto.Migration

  def change do
    execute("CREATE INDEX index_jobs_on_title ON jobs USING gin(to_tsvector('english', title))")
    execute("CREATE INDEX index_jobs_on_company ON jobs USING gin(to_tsvector('english', company))")
    execute("CREATE INDEX index_jobs_on_location ON jobs USING gin(to_tsvector('english', location))")
  end
end
