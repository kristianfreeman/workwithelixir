defmodule Workwithelixir.Repo.Migrations.AddContactEmailToJob do
  use Ecto.Migration

  def change do
    alter table(:jobs) do
      add :contact_email, :string
    end
  end
end
