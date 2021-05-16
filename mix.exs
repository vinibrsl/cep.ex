defmodule Cepex.MixProject do
  use Mix.Project

  def project do
    [
      app: :cepex,
      version: "0.1.0",
      elixir: ">= 1.9.4",
      description: "Brazilian zipcode lookup (CEP) library for Elixir",
      source_url: "https://github.com/vinibrsl/cep.ex",
      package: [licenses: ["MIT"], links: []],
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
      {:hackney, "~> 1.17", optional: true},
      {:ex_doc, "~> 0.24", only: :dev, runtime: false}
    ]
  end
end
