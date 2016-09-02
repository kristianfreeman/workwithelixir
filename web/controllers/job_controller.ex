defmodule Workwithelixir.JobController do
  require Logger
  use Workwithelixir.Web, :controller

  alias Workwithelixir.Job
  alias Workwithelixir.JobModule

  def index(conn, _params) do
    jobs = JobModule.retrieve_jobs()
    |> Enum.group_by(&(Job.format_date_for_sorting(&1)))
    render(conn, "index.html", jobs: jobs)
  end

  def search(conn, %{"query" => query}) do
    jobs = Job.search(query)
    render(conn, "search.html", jobs: jobs, query: query)
  end

  def new(conn, _params) do
    render(conn, "new.html", layout: {Workwithelixir.LayoutView, "posting.html"})
  end

  def create(conn, %{"job" => job_params}) do
    changeset = Job.changeset(%Job{}, job_params)

    case Repo.insert(changeset) do
      {:ok, _job} ->
        conn
        |> put_flash(:info, "Job created successfully.")
        |> redirect(to: job_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    job = Repo.get!(Job, id)
    render(conn, "show.html", job: job)
  end

  def edit(conn, %{"id" => id}) do
    job = Repo.get!(Job, id)
    changeset = Job.changeset(job)
    render(conn, "edit.html", job: job, changeset: changeset)
  end

  def update(conn, %{"id" => id, "job" => job_params}) do
    job = Repo.get!(Job, id)
    changeset = Job.changeset(job, job_params)

    case Repo.update(changeset) do
      {:ok, job} ->
        conn
        |> put_flash(:info, "Job updated successfully.")
        |> redirect(to: job_path(conn, :show, job))
      {:error, changeset} ->
        render(conn, "edit.html", job: job, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    job = Repo.get!(Job, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(job)

    conn
    |> put_flash(:info, "Job deleted successfully.")
    |> redirect(to: job_path(conn, :index))
  end

  def charge(conn, %{"id" => id, "token" => token}) do
    job = Repo.get!(Job, id)

    charge_key = Application.get_env(:workwithelixir, :charge_key)
    key = "#{charge_key}-job#{id}"
    hash = :crypto.hash(:sha256, key) |> Base.encode16 |> String.downcase

    public_key = Application.get_env(:workwithelixir, :stripe_public_key)

    if hash != token do
      conn
      |> put_flash(:info, "Sorry, that page isn't available.")
      |> redirect(to: job_path(conn, :index))
    end

    render(conn, "charge.html", job: job, public_key: public_key)
  end

  def charge(conn, %{"id" => id}) do
    conn
    |> put_flash(:info, "Sorry, that page isn't available.")
    |> redirect(to: job_path(conn, :index))
  end

  def accept_charge(conn, %{"id" => id, "stripeToken" => token}) do
    job = Repo.get!(Job, id)

    Logger.debug(token)
    params = [
      source: token,
      description: "Work With Elixir - Job Posting ##{id}"
    ]

    case Stripe.Charges.create(10000, params) do
      {:ok, charge} ->
        changeset = Job.changeset(job, %{"paid": true})
        case Repo.update(changeset) do
          {:ok, job} ->
            conn
            |> put_flash(:info, "Charge accepted. Thanks!")
            |> redirect(to: job_path(conn, :index))
          _ ->
            conn
            |> put_flash(:error, "Something went wrong!")
            |> redirect(to: job_path(conn, :index))
        end
      _ ->
        conn
        |> put_flash(:error, "Something went wrong!")
        |> redirect(to: job_path(conn, :index))
    end
  end
end
