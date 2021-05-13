defmodule Cepex.Address do
  @type t :: %__MODULE__{
          address: nil | String.t(),
          neighborhood: nil | String.t(),
          city: nil | String.t(),
          state: nil | String.t(),
          cep: nil | String.t(),
          complement: nil | String.t(),
          http_response: nil | Cepex.HTTP.Response.t()
        }

  defstruct [:address, :neighborhood, :city, :state, :cep, :complement, :http_response]
end
