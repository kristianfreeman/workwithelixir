defmodule Workwithelixir.JobTest do
  use Workwithelixir.ModelCase

  alias Workwithelixir.Job

  @valid_attrs %{title: "some content", company: "some content", location: "some content", company_url: "some content", contact_email: "some content", job_description: "some content", paid: false, status: "in review", apply_instructions: "some content"}
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
