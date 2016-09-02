# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Workwithelixir.Repo.insert!(%Workwithelixir.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Workwithelixir.Repo.delete_all Workwithelixir.User

Workwithelixir.User.changeset(%Workwithelixir.User{}, %{name: "Test User", email: "testuser@example.com", password: "secret", password_confirmation: "secret"})
|> Workwithelixir.Repo.insert!

Workwithelixir.Repo.delete_all Workwithelixir.Job
Workwithelixir.Job.changeset(%Workwithelixir.Job{}, %{
  title: "Backend Engineer",
  company: "Acme Co",
  salary: "$100-110k",
  location: "Los Angeles, CA",
  company_url: "https://acme.co",
  company_twitter: "@acmeco",
  job_description: "# Looking for a ninja rockstar developer",
  status: "In Review"
})
|> Workwithelixir.Repo.insert!

Workwithelixir.Job.changeset(%Workwithelixir.Job{}, %{
  title: "Frontend Engineer",
  company: "Google",
  salary: "$120-140k",
  location: "San Francisco, CA",
  company_url: "https://google.com",
  company_twitter: "@google",
  job_description: "# Algorithms",
  status: "In Review"
})
|> Workwithelixir.Repo.insert!
