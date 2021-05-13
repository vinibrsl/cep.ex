defmodule Cepex.HTTP.Response do
  @type t :: %__MODULE__{
          status: integer(),
          body: String.t(),
          headers: [Cepex.HTTP.header()]
        }

  defstruct [:status, :body, :headers]
end
