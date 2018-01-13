require 'test_helper'

class ZolnaEmbedPagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @zolna_embed_page = zolna_embed_pages(:one)
  end

  test "should get index" do
    get zolna_embed_pages_url
    assert_response :success
  end

  test "should get new" do
    get new_zolna_embed_page_url
    assert_response :success
  end

  test "should create zolna_embed_page" do
    assert_difference('ZolnaEmbedPage.count') do
      post zolna_embed_pages_url, params: { zolna_embed_page: { additional_tags: @zolna_embed_page.additional_tags, description: @zolna_embed_page.description, source_mp4_url: @zolna_embed_page.source_mp4_url, steemit_permalink: @zolna_embed_page.steemit_permalink, title: @zolna_embed_page.title, video_snap_url: @zolna_embed_page.video_snap_url } }
    end

    assert_redirected_to zolna_embed_page_url(ZolnaEmbedPage.last)
  end

  test "should show zolna_embed_page" do
    get zolna_embed_page_url(@zolna_embed_page)
    assert_response :success
  end

  test "should get edit" do
    get edit_zolna_embed_page_url(@zolna_embed_page)
    assert_response :success
  end

  test "should update zolna_embed_page" do
    patch zolna_embed_page_url(@zolna_embed_page), params: { zolna_embed_page: { additional_tags: @zolna_embed_page.additional_tags, description: @zolna_embed_page.description, source_mp4_url: @zolna_embed_page.source_mp4_url, steemit_permalink: @zolna_embed_page.steemit_permalink, title: @zolna_embed_page.title, video_snap_url: @zolna_embed_page.video_snap_url } }
    assert_redirected_to zolna_embed_page_url(@zolna_embed_page)
  end

  test "should destroy zolna_embed_page" do
    assert_difference('ZolnaEmbedPage.count', -1) do
      delete zolna_embed_page_url(@zolna_embed_page)
    end

    assert_redirected_to zolna_embed_pages_url
  end
end
