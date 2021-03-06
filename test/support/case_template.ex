defmodule Bittrex.TestSupport.CaseTemplate do
  @moduledoc false

  use ExUnit.CaseTemplate
  import Mox

  @response_headers [{"Content-Type", "application/json"}]

  using do
    quote do
      import Bittrex.TestSupport.CaseTemplate
      import Bittrex.TestSupport.Factory

      @client Bittrex.Client.new(%{api_key: "apikey", api_secret: "apisecret"})
    end
  end

  def stub_request(config) do
    tupple_status = Map.get(config, :tupple_status, :ok)
    headers = Map.get(config, :headers, @response_headers)

    response =
      Map.get(config, :response, %{
        status_code: Map.get(config, :status_code, 200),
        body: Map.get(config, :body, ""),
        headers: headers
      })

    stub(
      Bittrex.MockClient,
      :request,
      fn _method, _url, _body, _headers, _options ->
        {tupple_status, response}
      end
    )
  end
end
