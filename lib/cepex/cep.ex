defmodule Cepex.CEP do
  @moduledoc """
  This module provides functions related to the Brazilian postal code (CEP) string
  representation.

  A valid CEP has eight digits, e.g. `80010180` (check `t:Cepex.CEP.t/0`).
  """

  @typedoc """
  The Brazilian postal code (CEP) string representation without formatting, e.g. `80210130`.
  """
  @type t :: <<_::64>>

  @spec format(t) :: {:ok, <<_::72>>} | {:error, :invalid}
  @doc """
  Formats a valid CEP string. If the string may be invalid, call `Cepex.CEP.parse/1` first.

  ## Examples

      iex> Cepex.CEP.format("80210130")
      {:ok, "80210-130"}

      iex> Cepex.CEP.format(8344010)
      {:error, :invalid}

  """
  def format(cep)
  def format(<<head::binary-size(5), tail::binary-size(3)>>), do: {:ok, head <> "-" <> tail}
  def format(_cep), do: {:error, :invalid}

  @invalid_ceps ["", 0, "00000000", "00000-000"]
  @spec parse(any()) :: {:ok, t()} | {:error, :invalid}
  @doc """
  Parses a CEP string or integer. If the string is not a valid CEP (check `t:Cepex.CEP.t/0`),
  it tries building it by removing non-numeric characters and padding with zeros.

  ## Examples

      iex> Cepex.CEP.parse("80210130")
      {:ok, "80210130"}

      iex> Cepex.CEP.parse(80210130)
      {:ok, "80210130"}

      iex> Cepex.CEP.parse("80210-130")
      {:ok, "80210130"}

      iex> Cepex.CEP.parse(8344010)
      {:ok, "08344010"}

      iex> Cepex.CEP.parse("8344010")
      {:ok, "08344010"}

      iex> Cepex.CEP.parse("00000-000")
      {:error, :invalid}

      iex> Cepex.CEP.parse("80210130130130")
      {:error, :invalid}

  """
  def parse(cep)

  def parse(cep) when cep in @invalid_ceps, do: {:error, :invalid}

  def parse(cep) when is_binary(cep) do
    cep
    |> String.replace(~r/[^\d]/, "")
    |> String.pad_leading(8, "0")
    |> ensure_valid_cep()
  end

  def parse(cep) when is_integer(cep) do
    cep
    |> Kernel.abs()
    |> Integer.to_string()
    |> parse()
  end

  def parse(_cep), do: {:error, :invalid}

  defp ensure_valid_cep(<<_::binary-size(8)>> = cep), do: {:ok, cep}
  defp ensure_valid_cep(_cep), do: {:error, :invalid}
end
