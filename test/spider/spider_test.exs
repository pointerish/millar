defmodule Millar.SpiderTest do
  use ExUnit.Case

  test "spider gets scp data correctly when passed a string valid SCP number" do
    scp_data = Millar.Spider.get_scp("002")

    assert %{title: _title, content: _content} = scp_data
    assert [{"div", [{"id", "page-title"}], _}] = scp_data[:title]
    assert length(scp_data[:content]) != []
  end

  test "spider gets scp data correctly when passed an integer valid SCP number < 10" do
    scp_data = Millar.Spider.get_scp(001)

    assert %{title: _title, content: _content} = scp_data
    assert [{"div", [{"id", "page-title"}], _}] = scp_data[:title]
    assert length(scp_data[:content]) != []
  end

  test "spider gets scp data correctly when passed an integer valid SCP number >= 10 and < 100" do
    scp_data = Millar.Spider.get_scp(010)

    assert %{title: _title, content: _content} = scp_data
    assert [{"div", [{"id", "page-title"}], _}] = scp_data[:title]
    assert length(scp_data[:content]) != []
  end

  test "spider returns the correct error tuple when passed a non-existant SCP number" do
    scp_data = Millar.Spider.get_scp(10000)

    assert {:error, %{status_code: 404}} = scp_data
  end
end
