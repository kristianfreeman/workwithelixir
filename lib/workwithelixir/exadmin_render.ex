alias ExAdmin.Utils

defimpl ExAdmin.Render, for: Ecto.DateTime do
  def to_string(dt) do
    dt
    |> Utils.to_datetime
    # Remove conversion to local time
    # |> :calendar.universal_time_to_local_time
    |> Utils.format_datetime
  end
end
