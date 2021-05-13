defmodule Cepex.HTTP do
  @moduledoc """
  This is the behaviour to implement HTTP clients to use with Cepex. The library has a
  built-in implementation of hackney (check `Cepex.HTTP.Hackney`).
  """

  @type url :: String.t()
  @type header :: {key :: String.t(), value :: String.t()}

  @doc """
  Performs a GET HTTP request with the given parameters and returns a `Cepex.HTTP.Response`
  struct, when successful.
  """
  @callback get(url :: String.t(), headers :: [header]) ::
              {:ok, Cepex.HTTP.Response.t()} | {:error, any()}
end
