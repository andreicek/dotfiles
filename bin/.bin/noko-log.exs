#!/usr/bin/env elixir

# Setuo: Create a file ~/.config/noko.txt with content
# user_id=<YOUR ID>
# api_key=<YOUR API KEY>
# project_name=<YOUR PROJECT NAME>

Mix.install([
  {:httpoison, "~> 1.8"},
  {:poison, "~> 5.0"}
])

defmodule Log do
  @config_path "~/.config/noko.txt"
  @base_url "https://api.nokotime.com/v2/entries"

  def new(args) do
    with {:ok, config} <- get_config(@config_path) do
      config
      |> map_entry(args)
      |> save(config)
      |> IO.inspect(pretty: true, limit: :infinity)
    end
  end

  ###

  defp map_entry(%{"project_name" => project_name} = _config, {options, descirptions, _}) do
    date = Keyword.get(options, :date, get_today())
    hours = Keyword.get(options, :hours, 8)
    description = Enum.at(descirptions, 0)

    %{
      "date" => date,
      "minutes" => trunc(hours * 60),
      "description" => description,
      "project_name" => project_name
    }
  end

  defp save(entry, %{"api_key" => api_key} = _config) do
    entry = Poison.encode!(entry)

    headers = %{
      "User-Agent" => "SyncHours/1.0",
      "X-NokoToken" => api_key
    }

    @base_url
    |> HTTPoison.post!(entry, headers)
    |> Map.get(:body)
    |> Poison.decode!()
  end

  defp get_today, do: Date.utc_today() |> Date.to_iso8601()

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

System.argv()
|> OptionParser.parse(
  strict: [
    date: :string,
    hours: :float
  ]
)
|> Log.new()
