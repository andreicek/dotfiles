#!/usr/bin/env elixir

# Setuo: Create a file ~/.config/noko.txt with content
# user_id=<YOUR ID>
# api_key=<YOUR API KEY>

Mix.install([
  {:httpoison, "~> 1.8"},
  {:poison, "~> 5.0"}
])

defmodule Report do
  @config_path "~/.config/noko.txt"
  @base_url "https://api.nokotime.com/v2/entries"

  def hours_worked do
    with {:ok, config} <- get_config(@config_path) do
      calculate_billing_period()
      |> get_report(config)
    end
  end

  def calculate_billing_period(date \\ Date.utc_today())

  def calculate_billing_period(%{day: day, month: month, year: year} = _date)
      when day < 16 do
    from = create_iso8601(year, month - 1, 16)
    to = create_iso8601(year, month, 15)

    {from, to}
  end

  def calculate_billing_period(%{day: day, month: month, year: year} = _date)
      when day >= 16 and month != 12 do
    from = create_iso8601(year, month, 16)
    to = create_iso8601(year, month + 1, 15)

    {from, to}
  end

  def calculate_billing_period(%{month: month, year: year} = _date) do
    from = create_iso8601(year, month, 16)
    to = create_iso8601(year + 1, 1, 15)

    {from, to}
  end

  ###

  defp get_report({from, to}, %{"user_id" => user_id, "api_key" => api_key} = _config) do
    headers = %{
      "User-Agent" => "SyncHours/1.0",
      "X-NokoToken" => api_key
    }

    params = [
      user_ids: user_id,
      from: from,
      to: to
    ]

    @base_url
    |> HTTPoison.get!(headers, params: params)
    |> Map.get(:body)
    |> Poison.decode!()
  end

  defp create_iso8601(year, month, day) do
    year
    |> Date.new!(month, day)
    |> Date.to_iso8601()
  end

  defp get_config(config_path) do
    config_path = Path.expand(config_path)

    with {:ok, config} <- File.read(config_path) do
      config =
        config
        |> String.split("\n")
        |> Enum.map(fn
          "" ->
            nil

          key ->
            [key, value] = String.split(key, "=")

            {key, value}
        end)
        |> Enum.reject(&is_nil/1)
        |> Map.new()

      {:ok, config}
    end
  end
end

Report.calculate_billing_period()
|> IO.inspect(label: "For", pretty: true, limit: :infinity)

Report.hours_worked()
|> Enum.map(& &1["minutes"])
|> Enum.map(&(&1 / 60))
|> Enum.sum()
|> IO.inspect(label: "Worked", pretty: true, limit: :infinity)
