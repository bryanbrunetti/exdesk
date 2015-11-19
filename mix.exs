defmodule ExDesk.Mixfile do
  use Mix.Project

  def project do
    [app: :exdesk,
     version: "0.2.0",
     elixir: "~> 1.1",
     description: description,
     package: package,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [ mod: { ExDesk, [] },
      applications: [:inets, :ssl, :crypto]]
  end

  defp deps do
    [
      {:httpoison, "~> 0.8.0"},
      {:poison, "~> 1.5"},
      {:exvcr, "~> 0.6", only: [:test, :dev]}
    ]
  end

  defp description do
  """
  Desk.com client library for elixir.
  """
  end

  defp package do
  [
    maintainers: ["Bryan Brunetti"],
    links: %{"GitHub" => "https://github.com/deadkarma/exdesk"}
  ]
  end
end
