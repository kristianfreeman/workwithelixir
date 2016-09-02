defmodule Workwithelixir.Repo.Migrations.AddSearchesView do
  use Ecto.Migration

  def change do
    execute("
CREATE VIEW searches AS

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

    ")
  end
end
