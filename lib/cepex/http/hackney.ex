if Code.ensure_loaded?(:hackney) do
  defmodule Cepex.HTTP.Hackney do
    @moduledoc """
    This module is the hackney HTTP client library implementation of `Cepex.HTTP`.
    """

    @behaviour Cepex.HTTP

    @spec get(Cepex.HTTP.url(), [Cepex.HTTP.header()]) ::
            {:ok, Cepex.HTTP.Response.t()}
            | {:error, {:reading_body_failed, any()}}
            | {:error, {:request_failed, any()}}
    @impl true
    def get(url, headers) do
      with {:request, {:ok, status, headers, client_ref}} <-
             {:request, :hackney.request(:get, url, headers, "", follow_redirects: true)},
           {:body, {:ok, body}} when is_binary(body) <-
             {:body, :hackney.body(client_ref)} do
        {:ok, %Cepex.HTTP.Response{status: status, body: body, headers: headers}}
      else
        {:body, cause} -> {:error, {:reading_body_failed, cause}}
        {:request, cause} -> {:error, {:request_failed, cause}}
      end
    end
  end
end
