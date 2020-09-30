defmodule ExChain.BlockChain.Block do
  @moduledoc """
  This module is the single block struct in a blockchain
  """
  alias __MODULE__

  @type t :: %Block{
    timestamp: pos_integer(),
    last_hash: String.t(),
    hash: String.t(),
    data: any()
  }

  defstruct ~w(timestramp last_hash hash data)
end
