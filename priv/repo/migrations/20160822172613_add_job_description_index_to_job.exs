defmodule Workwithelixir.Repo.Migrations.AddJobDescriptionIndexToJob do
  use Ecto.Migration

  def change do
    execute("CREATE INDEX index_jobs_on_job_description ON jobs USING gin(to_tsvector('english', job_description))")
  end
end
