defmodule Workwithelixir.Repo.Migrations.AddJobTypes do
  use Ecto.Migration

  def change do
    alter table(:jobs) do
      add :permanent, :boolean, default: true, null: false
      add :remote, :boolean, default: false, null: false
    end
  end
end
