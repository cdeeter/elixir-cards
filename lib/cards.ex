defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Returns a deck (list of strings) representing a deck of playing cards
  """
  def create_deck do
    values = ["ace", "two", "three", "four", "five", "six",
              "seven", "eight", "nine", "ten", "jack", "queen", "king"]
    suits = ["hearts", "diamonds", "spades", "clubs"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
    Accepts a `deck` (list) and returns a shuffled version of the `deck`.
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Accepts a `deck` (list) and a `card` (string) and returns a boolean
    based on whether or not that `deck` contains the given `card`.

  ## Example

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "ace of spades")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a `deck` (list) into a `hand` (list) and returns the
    remainder of the `deck`. The `hand_size` (integer) argument
    indicates how many cards should be in the `hand`.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, _deck} = Cards.deal(deck, 1)
      iex> hand
      ["ace of hearts"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
    Accepts a `deck` (list) and a `filename` (string) and saves it.
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
    Accepts a `filename` (string) and returns the saved file.
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _reason} -> 'File does not exist'
    end
  end

  @doc """
    Accepts a `hand_size` (integer) returns a shuffled `hand` (list)
    of the size you passed in.
  """
  def create_hand(hand_size) do
    {hand, _deck} = create_deck() |> Cards.shuffle |> Cards.deal(hand_size)

    hand
  end

end
