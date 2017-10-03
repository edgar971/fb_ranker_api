defmodule FbRankerWeb.PostControllerTest do
  use FbRankerWeb.ConnCase

  alias FbRanker.Facebook
  alias FbRanker.Facebook.Post

  @create_attrs %{created_time: "some created_time", fb_id: "some fb_id", likes: 42, message: "some message", shares: 42, story: "some story"}
  @update_attrs %{created_time: "some updated created_time", fb_id: "some updated fb_id", likes: 43, message: "some updated message", shares: 43, story: "some updated story"}
  @invalid_attrs %{created_time: nil, fb_id: nil, likes: nil, message: nil, shares: nil, story: nil}

  def fixture(:post) do
    {:ok, post} = Facebook.create_post(@create_attrs)
    post
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all posts", %{conn: conn} do
      conn = get conn, post_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create post" do
    test "renders post when data is valid", %{conn: conn} do
      conn = post conn, post_path(conn, :create), post: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, post_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "created_time" => "some created_time",
        "fb_id" => "some fb_id",
        "likes" => 42,
        "message" => "some message",
        "shares" => 42,
        "story" => "some story"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, post_path(conn, :create), post: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update post" do
    setup [:create_post]

    test "renders post when data is valid", %{conn: conn, post: %Post{id: id} = post} do
      conn = put conn, post_path(conn, :update, post), post: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, post_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "created_time" => "some updated created_time",
        "fb_id" => "some updated fb_id",
        "likes" => 43,
        "message" => "some updated message",
        "shares" => 43,
        "story" => "some updated story"}
    end

    test "renders errors when data is invalid", %{conn: conn, post: post} do
      conn = put conn, post_path(conn, :update, post), post: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete post" do
    setup [:create_post]

    test "deletes chosen post", %{conn: conn, post: post} do
      conn = delete conn, post_path(conn, :delete, post)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, post_path(conn, :show, post)
      end
    end
  end

  defp create_post(_) do
    post = fixture(:post)
    {:ok, post: post}
  end
end
