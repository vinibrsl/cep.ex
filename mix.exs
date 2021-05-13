defmodule Cepex.MixProject do
  use Mix.Project

  def project do
    [
      app: :cepex,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :hackney]
    ]
  end

  defp deps do
    [
      {:hackney, "~> 1.17", optional: true}
    ]
  end
end
