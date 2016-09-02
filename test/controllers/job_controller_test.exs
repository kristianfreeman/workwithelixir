defmodule Workwithelixir.JobControllerTest do
  use Workwithelixir.ConnCase

  alias Workwithelixir.Job
  @valid_attrs %{company: "some content", company_twitter: "some content", company_url: "some content", job_description: "some content", location: "some content", paid: true, posted: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, reviewed_by: "some content", salary: "some content", status: "some content", title: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, job_path(conn, :index)
    assert html_response(conn, 200) =~ "job"
  end

  # test "shows chosen resource", %{conn: conn} do
  #   job = Repo.insert! Job, @valid_attrs
  #   conn = get conn, job_path(conn, :show, job)
  #   assert html_response(conn, 200) =~ "Show job"
  # end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, job_path(conn, :show, -1)
    end
  end
end
