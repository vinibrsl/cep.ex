defmodule Cepex.Service.ViaCEP do
  @moduledoc """
  The `Cepex.Service.ViaCEP` implements the [ViaCEP](https://viacep.com.br) API.
  """

  @behaviour Cepex.Service

  @impl true
  def lookup(http_client, cep) do
    "https://viacep.com.br/ws/#{cep}/querty"
    |> http_client.get([])
    |> ensure_http_ok()
    |> mount_address(cep)
  end

  @mapping [
    {:neighborhood, "bairro"},
    {:complement, "complemento"},
    {:city, "localidade"},
    {:address, "logradouro"},
    {:state, "uf"}
  ]
  defp mount_address({:ok, %Cepex.HTTP.Response{body: body} = response}, cep) do
    raw = body |> URI.query_decoder() |> Map.new()

    address_map =
      @mapping
      |> Enum.map(fn {cepex_key, raw_key} -> {cepex_key, Map.get(raw, raw_key)} end)
      |> Map.new()
      |> Map.put(:http_response, response)
      |> Map.put(:cep, cep)

    {:ok, struct(Cepex.Address, address_map)}
  end

  defp mount_address({:error, cause}, _cep), do: {:error, cause}

  defp ensure_http_ok({:ok, %Cepex.HTTP.Response{body: "erro=true"}}),
    do: {:error, :cep_not_found}

  defp ensure_http_ok({:ok, %Cepex.HTTP.Response{status: status, body: body} = response})
       when status in 200..299 and is_binary(body),
       do: {:ok, response}

  defp ensure_http_ok({:ok, %Cepex.HTTP.Response{} = response}),
    do: {:error, {:invalid_response, response}}

  defp ensure_http_ok({:error, _cause}), do: {:error, :request_failed}
end
