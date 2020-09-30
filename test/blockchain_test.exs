defmodule ExChain.BlockchainTest do
  @moduledoc """
  This module contains test related to a blockchain
  """
  use ExUnit.Case
  alias ExChain.Blockchain
  alias ExChain.Blockchain.Block

  describe "Blockchain" do
    setup [:initialize_blockchain]

    test "should start with genesis block", %{blockchain: blockchain} do
      assert %Block{
        data: "genesis data",
        hash: "F277BF9150CD035D55BA5B48CB5BCBE8E564B134E5AD0D56E439DD04A1528D3B",
        last_hash: "-",
        timestamp: 1_599_909_623_805_627
      } == hd(blockchain.chain)
    end

    test "adds a new block", %{blockchain: blockchain} do
      data = "foo"
      blockchain = Blockchain.add_block(blockchain, data)
      [_, block] = blockchain.chain
      assert block.data == data
    end

    test "validates a blockchain", %{blockchain: blockchain} do
      blockchain = Blockchain.add_block(blockchain, "some-bullshit")
      assert Blockchain.valid_chain?(blockchain)
    end

    test "when we temper data in an existing blockchain", %{blockchain: blockchain} do
      blockchain =
        blockchain
        |> Blockchain.add_block("blockchain-data-block-1")
        |> Blockchain.add_block("blockchain-data-block-2")
        |> Blockchain.add_block("blockchain-data-block-3")

      assert Blockchain.valid_chain?(blockchain)
        index = 2
        tempered_block = put_in(Enum.at(blockchain.chain, index).data, "tempered-data")
        blockchain = %Blockchain{chain: List.replace_at(blockchain.chain, index, tempered_block)}
        refute Blockchain.valid_chain?(blockchain)
    end
  end

  defp initialize_blockchain(context), do: Map.put(context, :blockchain, Blockchain.new)
end
