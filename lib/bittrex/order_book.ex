defmodule Bittrex.OrderBook do
  @moduledoc """
  A Bittrex Order Book.
  """

  alias StrawHat.Response
  alias Bittrex.OrderBookEntry

  @typedoc """
  - `bid`: buy entries.
  - `ask`: sell entries.
  """
  @type t :: %__MODULE__{
          bid: [%OrderBookEntry{}],
          ask: [%OrderBookEntry{}]
        }

  defstruct [:bid, :ask]

  @doc false
  def new(data) do
    %__MODULE__{
      bid: Enum.map(data["bid"], &OrderBookEntry.new/1),
      ask: Enum.map(data["ask"], &OrderBookEntry.new/1)
    }
  end

  @doc false
  def transform_response(data) do
    data
    |> new()
    |> Response.ok()
  end
end
