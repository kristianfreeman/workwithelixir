defmodule Workwithelixir.JobTest do
  use Workwithelixir.ModelCase

  alias Workwithelixir.Job

  @valid_attrs %{company: "some content", company_twitter: "some content", company_url: "some content", job_description: "some content", location: "some content", paid: true, posted: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, reviewed_by: "some content", salary: "some content", status: "some content", title: "some content", list: ["some", "content"]}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Job.changeset(%Job{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Job.changeset(%Job{}, @invalid_attrs)
    refute changeset.valid?
  end
end
