defmodule FbRanker.FacebookTest do
  use FbRanker.DataCase

  alias FbRanker.Facebook

  describe "pages" do
    alias FbRanker.Facebook.Page

    @valid_attrs %{about: "some about", fan_count: 42, name: "some name", page_id: "some page_id"}
    @update_attrs %{about: "some updated about", fan_count: 43, name: "some updated name", page_id: "some updated page_id"}
    @invalid_attrs %{about: nil, fan_count: nil, name: nil, page_id: nil}

    def page_fixture(attrs \\ %{}) do
      {:ok, page} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Facebook.create_page()

      page
    end

    test "list_pages/0 returns all pages" do
      page = page_fixture()
      assert Facebook.list_pages() == [page]
    end

    test "get_page!/1 returns the page with given id" do
      page = page_fixture()
      assert Facebook.get_page!(page.id) == page
    end

    test "create_page/1 with valid data creates a page" do
      assert {:ok, %Page{} = page} = Facebook.create_page(@valid_attrs)
      assert page.about == "some about"
      assert page.fan_count == 42
      assert page.name == "some name"
      assert page.page_id == "some page_id"
    end

    test "create_page/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Facebook.create_page(@invalid_attrs)
    end

    test "update_page/2 with valid data updates the page" do
      page = page_fixture()
      assert {:ok, page} = Facebook.update_page(page, @update_attrs)
      assert %Page{} = page
      assert page.about == "some updated about"
      assert page.fan_count == 43
      assert page.name == "some updated name"
      assert page.page_id == "some updated page_id"
    end

    test "update_page/2 with invalid data returns error changeset" do
      page = page_fixture()
      assert {:error, %Ecto.Changeset{}} = Facebook.update_page(page, @invalid_attrs)
      assert page == Facebook.get_page!(page.id)
    end

    test "delete_page/1 deletes the page" do
      page = page_fixture()
      assert {:ok, %Page{}} = Facebook.delete_page(page)
      assert_raise Ecto.NoResultsError, fn -> Facebook.get_page!(page.id) end
    end

    test "change_page/1 returns a page changeset" do
      page = page_fixture()
      assert %Ecto.Changeset{} = Facebook.change_page(page)
    end
  end
end
