defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck creates 20 cards" do
    assert length(Cards.create_deck) == 52
  end

  test "shuffle randomizes deck" do
    deck = Cards.create_deck
    refute deck == Cards.shuffle(deck)
  end

  test "create_hand creates prescribed hand size" do
    {hand, _} = Cards.create_hand(5)
    assert length(hand) == 5
  end
end
