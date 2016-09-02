defimpl ExAdmin.Authentication, for: Plug.Conn do
  alias Workwithelixir.Router.Helpers
  alias Workwithelixir.Authentication, as: Auth

  def use_authentication?(_), do: true
  def current_user(conn), do: Auth.current_user(conn)
  def current_user_name(conn), do: "Admin"
  def session_path(conn, :destroy), do: Helpers.session_path(conn, :delete, 0)
  def session_path(conn, action), do: Helpers.session_path(conn, action)
end

defmodule Workwithelixir.Authentication do
  def current_user(conn) do
    Coherence.current_user(conn)
  end
end
