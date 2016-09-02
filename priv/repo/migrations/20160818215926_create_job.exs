defmodule Workwithelixir.Repo.Migrations.CreateJob do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :title, :string
      add :company, :string
      add :salary, :string
      add :location, :string
      add :company_url, :string
      add :company_twitter, :string
      add :job_description, :text
      add :paid, :boolean, default: false, null: false
      add :status, :string
      add :reviewed_by, :string
      add :posted, :datetime
      add :tags, {:array, :string}

      timestamps()
    end

  end
end
