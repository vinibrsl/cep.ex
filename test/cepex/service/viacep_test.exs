defmodule Cepex.Service.ViaCEPTest do
  use ExUnit.Case

  defmodule ViaCEPErrorMock do
    @behaviour Cepex.HTTP
    def get(_url, _headers), do: {:ok, %Cepex.HTTP.Response{status: 500}}
  end

  test "returns the address" do
    assert {:ok,
            %Cepex.Address{
              address: "Rua José Ananias Mauad",
              cep: "80210130",
              city: "Curitiba",
              complement: "",
              http_response: %Cepex.HTTP.Response{},
              neighborhood: "Jardim Botânico",
              state: "PR"
            }} = Cepex.Service.ViaCEP.lookup(Cepex.HTTP.Hackney, "80210130")
  end

  test "returns error when cep does not exist" do
    assert {:error, :cep_not_found} = Cepex.Service.ViaCEP.lookup(Cepex.HTTP.Hackney, "00000000")
  end

  test "returns error when request fails" do
    assert {:error, {:invalid_response, %Cepex.HTTP.Response{status: 500}}} =
             Cepex.Service.ViaCEP.lookup(ViaCEPErrorMock, "00000000")
  end
end
