defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck makes 52 cards" do
    deck_length = length(Cards.create_deck)
    assert deck_length == 52
  end

  test "shuffling a deck randomizes it" do
    deck = Cards.create_deck
    refute deck == Cards.shuffle(deck)
  end

  test "you can load a saved deck" do
    original_deck = Cards.create_deck
    Cards.save(original_deck, "my_deck")
    saved_deck = Cards.load("my_deck")
    assert saved_deck == original_deck
  end

  test "deal outputs the correct number of cards" do
    deck = Cards.create_deck
    {hand, _deck} = Cards.deal(deck, 5)
    hand_length = length(hand)
    assert hand_length == 5
  end
end
