defmodule Millar.MixProject do
  use Mix.Project

  def project do
    [
      app: :millar,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Millar.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cowboy, "~> 2.9"},
      {:plug, "~> 1.13"},
      {:plug_cowboy, "~> 2.5"},
      {:jason, "~> 1.3"},
      {:poison, "~> 5.0"},
      {:ex_doc, "~> 0.28.3", only: :dev, runtime: false},
      {:httpoison, "~> 1.8"},
      {:floki, "~> 0.26.0"},
      {:pockets, "~> 0.1.0"}
    ]
  end
end
