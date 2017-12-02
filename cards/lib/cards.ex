defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards.
  """
  
  @doc """
    Shuffles the deck of cards.
  """
  defdelegate shuffle(deck), to: Enum

  @doc """
    Checks whether the deck contains a card.

  ## Examples
    
    iex> deck = Cards.create_deck
    iex> deck |> Cards.contains?("Ace of Spades")
    true
  """
  defdelegate contains?(deck, card), to: Enum, as: :member?

  @doc """
    Creates a deck of plaing cards.
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end
  
  @doc """
    Divides a deck into a hand and the remaining deck.
    The `hand_size` argument indicates how many cards should be dealt.

  ## Examples
    
      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
    Saves the `deck` to `filename` as binary.
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
    Loads a deck from `filename`.
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _} -> "That file does not exist"
    end
  end

  @doc """
    Helper for quickly geting a hand of cards from a new deck.
  """
  def create_hand(hand_size) do
    create_deck() |> shuffle |> deal(hand_size)
  end
end
