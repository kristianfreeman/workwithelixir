defmodule Workwithelixir.JobControllerTest do
  use Workwithelixir.ConnCase

  alias Workwithelixir.Job
  @valid_attrs %{company: "some content", company_twitter: "some content", company_url: "some content", job_description: "some content", location: "some content", paid: true, posted: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, reviewed_by: "some content", salary: "some content", status: "some content", title: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, job_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing jobs"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, job_path(conn, :new)
    assert html_response(conn, 200) =~ "New job"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, job_path(conn, :create), job: @valid_attrs
    assert redirected_to(conn) == job_path(conn, :index)
    assert Repo.get_by(Job, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, job_path(conn, :create), job: @invalid_attrs
    assert html_response(conn, 200) =~ "New job"
  end

  test "shows chosen resource", %{conn: conn} do
    job = Repo.insert! %Job{}
    conn = get conn, job_path(conn, :show, job)
    assert html_response(conn, 200) =~ "Show job"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, job_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    job = Repo.insert! %Job{}
    conn = get conn, job_path(conn, :edit, job)
    assert html_response(conn, 200) =~ "Edit job"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    job = Repo.insert! %Job{}
    conn = put conn, job_path(conn, :update, job), job: @valid_attrs
    assert redirected_to(conn) == job_path(conn, :show, job)
    assert Repo.get_by(Job, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    job = Repo.insert! %Job{}
    conn = put conn, job_path(conn, :update, job), job: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit job"
  end

  test "deletes chosen resource", %{conn: conn} do
    job = Repo.insert! %Job{}
    conn = delete conn, job_path(conn, :delete, job)
    assert redirected_to(conn) == job_path(conn, :index)
    refute Repo.get(Job, job.id)
  end
end
