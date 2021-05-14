defmodule CepexTest do
  use ExUnit.Case

  defmodule RequestErrorMock do
    @behaviour Cepex.HTTP
    def get(_url, _headers), do: {:error, :request_failed}
  end

  defmodule InvalidResponseMock do
    @behaviour Cepex.HTTP
    def get(_url, _headers), do: {:ok, %Cepex.HTTP.Response{status: 500}}
  end

  test "returns the address" do
    assert {:ok,
            %Cepex.Address{
              address: "Rua Barão do Rio Branco",
              cep: "80010180",
              city: "Curitiba",
              complement: "",
              http_response: %Cepex.HTTP.Response{},
              neighborhood: "Centro",
              state: "PR"
            }} = Cepex.lookup(80_010_180)
  end

  test "when request fails returns error" do
    assert {:error, :request_failed} = Cepex.lookup(80_010_180, http_client: RequestErrorMock)
  end

  test "when response is invalid returns error" do
    assert {:error, {:invalid_response, %Cepex.HTTP.Response{status: 500}}} =
             Cepex.lookup(80_010_180, http_client: InvalidResponseMock)
  end

  test "when the cep is invalid returns error" do
    assert {:error, :invalid_cep} = Cepex.lookup("")
  end

  test "when the cep cannot be found returns error" do
    assert {:error, :cep_not_found} = Cepex.lookup("00000001")
  end
end
