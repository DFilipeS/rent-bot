defmodule CrawlerTest do
  use ExUnit.Case
  doctest Crawler

  test "greets the world" do
    assert Crawler.hello() == :world
  end
end
