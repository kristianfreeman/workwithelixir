defmodule Workwithelixir.Repo.Migrations.UpdateSearchView do
  use Ecto.Migration

  def change do
    execute("DROP VIEW searches")

    execute("
CREATE OR REPLACE VIEW searches AS

  SELECT
    jobs.id AS searchable_id,
    'Job' AS searchable_type,
    jobs.title AS term
  FROM jobs

  UNION

  SELECT
    jobs.id AS searchable_id,
    'Job' AS searchable_type,
    jobs.company AS term
  FROM jobs

  UNION

  SELECT
    jobs.id AS searchable_id,
    'Job' AS searchable_type,
    jobs.location AS term
  FROM jobs

  UNION

  SELECT
    jobs.id AS searchable_id,
    'Job' AS searchable_type,
    jobs.job_description AS term
  FROM jobs

    ")
  end
end
