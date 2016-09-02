defmodule Workwithelixir.Repo do
  use Ecto.Repo, otp_app: :workwithelixir
  use Scrivener, page_size: 10

  def execute_and_load(sql, params, model) do
    Ecto.Adapters.SQL.query!(__MODULE__, sql, params)
    |> load_into(model)
  end

  defp load_into(response, model) do
    Enum.map(response.rows, fn row ->
      fields = Enum.reduce(Enum.zip(response.columns, row), %{}, fn({key, value}, map) ->
        Map.put(map, key, value)
      end)
      Ecto.Schema.__load__(model, nil, nil, nil, fields,
                           &Ecto.Type.adapter_load(__adapter__, &1, &2))
    end)
  end
end
