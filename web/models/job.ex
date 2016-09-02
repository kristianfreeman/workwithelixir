defmodule Workwithelixir.Job do
  use Timex
  alias Workwithelixir.Repo
  alias Workwithelixir.Job
  use Workwithelixir.Web, :model

  schema "jobs" do
    field :apply_instructions, :string
    field :apply_url, :string
    field :company, :string
    field :company_twitter, :string
    field :company_url, :string
    field :contact_email, :string
    field :job_description, :string
    field :location, :string
    field :paid, :boolean, default: false
    field :permanent, :boolean
    field :posted, Ecto.DateTime
    field :remote, :boolean
    field :reviewed_by, :string
    field :salary, :string
    field :status, :string
    field :title, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :company, :salary, :location, :company_url, :company_twitter, :contact_email, :job_description, :paid, :status, :reviewed_by, :posted, :apply_instructions, :apply_url, :permanent, :remote])
    |> validate_required([:title, :company, :location, :company_url, :contact_email, :job_description, :paid, :status, :apply_instructions])
  end

  def format_date_for_sorting(job) do
    {:ok, date} = Ecto.DateTime.dump(job.posted)
    Timex.format!(date, "%m/%d", :strftime)
  end

  def format_date(job) do
    {:ok, date} = Ecto.DateTime.dump(job.posted)
    Timex.format!(date, "%B %e", :strftime)
  end

  @doc """
  Search for jobs based on a provided term, using Postgres full-text search.

  Returns [Job]
  """
  def search(term) do
    formatted = term |> String.replace(" ", "|")
    Repo.execute_and_load("select * from jobs where id in (select searchable_id from searches where to_tsvector('english', term) @@ to_tsquery($1)) and status = 'Live';", [ formatted ], Job)
  end

  def hash_for_charge(job) do
    charge_key = Application.get_env(:workwithelixir, :charge_key)
    key = "#{charge_key}-job#{job.id}"
    :crypto.hash(:sha256, key) |> Base.encode16 |> String.downcase
  end

  def truncated_description(job) do
    job.job_description
    |> String.split("\n")
    |> Enum.at(0)
    |> String.trim
  end
end
