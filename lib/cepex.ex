defmodule Cepex do
  @spec lookup(String.t() | integer(), [keyword()]) ::
          {:ok, Cepex.Address.t()}
          | {:error, :request_failed}
          | {:error, {:invalid_response, Cepex.HTTP.Response.t()}}
          | {:error, :invalid_cep}
          | {:error, :cep_not_found}
  @doc """
  Lookups a postal code (CEP) and returns a `Cepex.Address` struct with the address
  information.

  Available options are `http_client` (defaults to `Cepex.HTTP.Hackney`) and `service`
  (defaults to `Cepex.Service.ViaCEP`).

    ## Examples

    iex> Cepex.lookup("80010-180")
    {:ok, %Cepex.Address{
      address: "Rua Barão do Rio Branco",
      cep: "80010180",
      city: "Curitiba",
      complement: "",
      http_response: %Cepex.HTTP.Response{},
      neighborhood: "Centro",
      state: "PR"
    }}

    iex> Cepex.lookup(80010180)
    {:ok, %Cepex.Address{
      address: "Rua Barão do Rio Branco",
      cep: "80010180",
      city: "Curitiba",
      complement: "",
      http_response: %Cepex.HTTP.Response{},
      neighborhood: "Centro",
      state: "PR"
    }}

    iex> Cepex.lookup("80210130")
    {:ok, %Cepex.Address{
      address: "Rua Barão do Rio Branco",
      cep: "80010180",
      city: "Curitiba",
      complement: "",
      http_response: %Cepex.HTTP.Response{},
      neighborhood: "Centro",
      state: "PR"
    }}

  """
  def lookup(cep, opts \\ []) do
    opts = Keyword.merge([http_client: get_http_client(), service: get_service()], opts)

    with {:parse, {:ok, cep}} <- {:parse, Cepex.CEP.parse(cep)},
         {:request, {:ok, address}} <- {:request, opts[:service].lookup(opts[:http_client], cep)} do
      {:ok, address}
    else
      {:parse, {:error, _cause}} -> {:error, :invalid_cep}
      {:request, {:error, cause}} -> {:error, cause}
    end
  end

  defp get_http_client, do: Application.get_env(:cepex, :http_client, Cepex.HTTP.Hackney)
  defp get_service, do: Application.get_env(:cepex, :service, Cepex.Service.ViaCEP)
end
