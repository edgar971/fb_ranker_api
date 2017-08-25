defmodule FbRankerWeb.PageControllerTest do
  use FbRankerWeb.ConnCase

  alias FbRanker.Facebook
  alias FbRanker.Facebook.Page

  @create_attrs %{about: "some about", fan_count: 42, name: "some name", page_id: "some page_id"}
  @update_attrs %{about: "some updated about", fan_count: 43, name: "some updated name", page_id: "some updated page_id"}
  @invalid_attrs %{about: nil, fan_count: nil, name: nil, page_id: nil}

  def fixture(:page) do
    {:ok, page} = Facebook.create_page(@create_attrs)
    page
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all pages", %{conn: conn} do
      conn = get conn, page_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create page" do
    test "renders page when data is valid", %{conn: conn} do
      conn = post conn, page_path(conn, :create), page: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, page_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "about" => "some about",
        "fan_count" => 42,
        "name" => "some name",
        "page_id" => "some page_id"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, page_path(conn, :create), page: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update page" do
    setup [:create_page]

    test "renders page when data is valid", %{conn: conn, page: %Page{id: id} = page} do
      conn = put conn, page_path(conn, :update, page), page: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, page_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "about" => "some updated about",
        "fan_count" => 43,
        "name" => "some updated name",
        "page_id" => "some updated page_id"}
    end

    test "renders errors when data is invalid", %{conn: conn, page: page} do
      conn = put conn, page_path(conn, :update, page), page: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete page" do
    setup [:create_page]

    test "deletes chosen page", %{conn: conn, page: page} do
      conn = delete conn, page_path(conn, :delete, page)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, page_path(conn, :show, page)
      end
    end
  end

  defp create_page(_) do
    page = fixture(:page)
    {:ok, page: page}
  end
end
