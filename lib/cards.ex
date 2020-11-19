defmodule Cards do
  @moduledoc """
  Provides methods for creating and hanlding a deck of `Cards`.
  """

  @doc """
   Returns a list of playing decs.
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Shades", "Clubs", "Hearts", "Diamond"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(cards) do
    Enum.shuffle(cards)
  end

  @doc """
    Determines if a deck contains a given value

  ##  Examples
        iex> deck = Cards.create_deck
        iex> Cards.contains?(deck, "Ace of Shades")
        true
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Devides a deck into hand and remainder.
    It takes `deck` and `hand_size`

   ## Examples
        iex> deck = Cards.create_deck
        iex> {hand, _deck} = Cards.deal(deck, 1)
        iex> hand
        ["Ace of Shades"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename)  do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
    {:ok, binary}-> :erlang.binary_to_term binary
    {:error, _reason} -> "File #{filename} does not exist"
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
