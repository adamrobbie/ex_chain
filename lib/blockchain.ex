defmodule ExChain.Blockchain do
  @moduledoc """
  This module contains the blockchain related functions
  """

  alias __MODULE__
  alias ExChain.Blockchain.Block

  defstruct ~w(chain)a

  @type t :: %Blockchain{
    chain: [Block.t({})]
  }

  @spec new() :: Blockchain.t()
  def new() do
    %__MODULE__{}
    |> add_gensis()
  end

  @spec add_block(Blockchain.t(), any) :: Blockchain.t()
  def add_block(blockchain = %__MODULE__{chain: chain}, data) do
    {last_block, _} = List.pop_at(chain, -1)

    %{blockchain | chain: chain ++ [Block.mine_block(last_block, data)]}
  end

  @spec valid_chain?(Blockchain.t()) :: boolean
  def valid_chain?(%__MODULE__{} = blockchain) do
    blockchain.chain
    |> List.delete_at(0)
    |> Enum.with_index(1)
    |> Enum.map(fn {current_block, index} ->
      last_block = Enum.at(blockchain.chain, index - 1)

      valid_last_hash?(last_block, current_block) &&
        valid_block_hash?(current_block)
    end)
    |> Enum.all?(&(&1 == true))
  end

  # private functions
  defp add_gensis(blockchain = %__MODULE__{}) do
    %{blockchain | chain: [Block.genesis()] }
  end

  defp valid_last_hash?(
    %Block{hash: hash} = _last_block,
    %Block{last_hash: last_hash} = _last_hash
  ) do
    hash == last_hash
  end

  defp valid_block_hash?(current_block) do
    current_block.hash == Block.block_hash(current_block)
  end
end
