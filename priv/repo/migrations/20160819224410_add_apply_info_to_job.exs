defmodule Workwithelixir.Repo.Migrations.AddApplyInfoToJob do
  use Ecto.Migration

  def change do
    alter table(:jobs) do
      add :apply_instructions, :string
      add :apply_url, :string
    end
  end
end
