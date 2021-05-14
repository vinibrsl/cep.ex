defmodule Cepex.Service do
  @moduledoc """
  The `Cepex.Service` defines the behaviour for postal code lookup APIs.
  """

  @doc """
  Lookups a postal code (CEP) and returns a `Cepex.Address` struct with the address
  information.
  """
  @callback lookup(http_client :: module(), cep :: Cepex.CEP.t()) ::
              {:ok, Cepex.Address.t()}
              | {:error, :cep_not_found}
              | {:error, :request_failed}
              | {:error, {:invalid_response, Cepex.HTTP.Response.t()}}
end
