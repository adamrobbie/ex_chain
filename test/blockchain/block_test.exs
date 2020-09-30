defmodule ExChain.Blockchain.BlockTest do
  @moduledoc """
  This module contains test related to a block
  """
  use ExUnit.TestCase
  alias ExChain.Blockchain.Block

  describe "block" do
    test ".genesis is valid" do
      assert %Block{
        data: "genesis data",
        hash: "genesis-hash",
        last_hash: "-",
        timestamp: 1_599_909_623_805_627
      } == Block.genesis()
    end

    test ".new gives a new block when we pass in params" do
      timestamp = DateTime.utc_now() |> DateTime.to_unix(1_000_000)
      data = "this is new block data"
      last_hash = "random_hash_last_block"

      assert %Block{timestamp: ^timestamp, hash: hash, last_hash: ^last_hash, data: ^data} =
               Block.new(timestamp, hash, last_hash, data)
    end
  end
end
