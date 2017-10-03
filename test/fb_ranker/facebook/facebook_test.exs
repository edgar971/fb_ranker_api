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

  describe "posts" do
    alias FbRanker.Facebook.Post

    @valid_attrs %{created_time: "some created_time", fb_id: "some fb_id", likes: 42, message: "some message", shares: 42, story: "some story"}
    @update_attrs %{created_time: "some updated created_time", fb_id: "some updated fb_id", likes: 43, message: "some updated message", shares: 43, story: "some updated story"}
    @invalid_attrs %{created_time: nil, fb_id: nil, likes: nil, message: nil, shares: nil, story: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Facebook.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Facebook.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Facebook.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Facebook.create_post(@valid_attrs)
      assert post.created_time == "some created_time"
      assert post.fb_id == "some fb_id"
      assert post.likes == 42
      assert post.message == "some message"
      assert post.shares == 42
      assert post.story == "some story"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Facebook.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, post} = Facebook.update_post(post, @update_attrs)
      assert %Post{} = post
      assert post.created_time == "some updated created_time"
      assert post.fb_id == "some updated fb_id"
      assert post.likes == 43
      assert post.message == "some updated message"
      assert post.shares == 43
      assert post.story == "some updated story"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Facebook.update_post(post, @invalid_attrs)
      assert post == Facebook.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Facebook.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Facebook.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Facebook.change_post(post)
    end
  end
end
