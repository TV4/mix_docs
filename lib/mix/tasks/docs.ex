defmodule Mix.Tasks.Docs do
  use Mix.Task

  @moduledoc """
    Generates online HTML documentation using Aglio <https://github.com/danielgtaylor/aglio>.
  """

  @shortdoc "Generate online docs with Aglio"
  def run(options) do
    case Enum.member?(options, "--watch") do
      true ->
        &watch/0

      false ->
        &generate_docs/0
    end
    |> apply([])
  end

  def watch() do
    {:ok, pid} = FileSystem.start_link(dirs: ["docs/blueprint.apib"])
    FileSystem.subscribe(pid)
    listen_loop()
  end

  defp listen_loop() do
    generate_docs()

    receive do
      # Something happened to our blueprint file
      {:file_event, _from, {_path, _}} ->
        listen_loop()

      _unexpected ->
        :stop
    end
  end

  defp generate_docs() do
    IO.puts("Generating online documentation using Aglio")

    {_, 0} = System.cmd("mkdir", ~w(-p priv/static/docs))

    {_, 0} =
      System.cmd(
        "npx",
        ~w(aglio -i docs/blueprint.apib -o priv/static/docs/index.html)
      )
  end
end
