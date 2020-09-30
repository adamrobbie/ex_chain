defmodule ExChain.Blockchain.BlockTest do
  @moduledoc """
  This module contains test related to a block
  """
  use ExUnit. Case
  alias ExChain.Blockchain.Block

  describe "block" do
    test ".genesis is valid" do
      assert %Block{
        data: "genesis data",
        hash: "F277BF9150CD035D55BA5B48CB5BCBE8E564B134E5AD0D56E439DD04A1528D3B",
        last_hash: "-",
        timestamp: 1_599_909_623_805_627
      } == Block.genesis()
    end

    test ".new gives a new block when we pass in params" do
      timestamp = DateTime.utc_now() |> DateTime.to_unix(1_000_000)
      data = "this is new block data"
      last_hash = "-"
      # hash = "random_hash_last_block"

      assert %Block{timestamp: ^timestamp, hash: _hash, last_hash: ^last_hash, data: ^data} =
               Block.new(timestamp, last_hash, data)
    end
  end

  test ".mine_block returns a new block" do
    %Block{hash: hash} = genesis_block = Block.genesis()

    assert %Block{
      data: "this is mined data",
      last_hash: ^hash
    } = Block.mine_block(genesis_block, "this is mined data")
  end
end
