class ZolnaEmbedPagesController < ApplicationController
  before_action :set_zolna_embed_page, only: [:next, :post_to_steemit, :skip_posting, :favorite, :show, :edit, :update, :destroy]

  # GET /zolna_embed_pages
  def index
    @zolna_embed_pages = ZolnaEmbedPage.postable
  end

  # GET /zolna_embed_pages/1
  # def show
  # end

  def favorite
    @zolna_embed_page.update(favorite: true)
    render :edit
  end

  def last
    redirect_to(edit_zolna_embed_page_path(ZolnaEmbedPage.postable.first))
  end

  def next
    redirect_to(edit_zolna_embed_page_path(ZolnaEmbedPage.postable_next(@zolna_embed_page).first))
  end

  def post_to_steemit
    @zolna_embed_page.add_to_queue
    redirect_to(edit_zolna_embed_page_path(ZolnaEmbedPage.postable_next(@zolna_embed_page).first))
  end

  def skip_posting
    @zolna_embed_page.skip_posting
    redirect_to(edit_zolna_embed_page_path(ZolnaEmbedPage.postable_next(@zolna_embed_page).first))
  end

  # GET /zolna_embed_pages/new
  def new
    @zolna_embed_page = ZolnaEmbedPage.new
  end

  # GET /zolna_embed_pages/1/edit
  def edit
  end

  # POST /zolna_embed_pages
  def create
    @zolna_embed_page = ZolnaEmbedPage.new(zolna_embed_page_params)

    if @zolna_embed_page.save
      redirect_to @zolna_embed_page, notice: 'Zolna embed page was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /zolna_embed_pages/1
  def update
    if @zolna_embed_page.update(zolna_embed_page_params)
      redirect_to edit_zolna_embed_page_path(@zolna_embed_page)
    else
      render :edit
    end
  end

  # DELETE /zolna_embed_pages/1
  def destroy
    @zolna_embed_page.destroy
    redirect_to zolna_embed_pages_url, notice: 'Zolna embed page was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_zolna_embed_page
      @zolna_embed_page = ZolnaEmbedPage.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def zolna_embed_page_params
      params.require(:zolna_embed_page).permit(:title, :description, :video_snap_url, :source_mp4_url, :additional_tags, :steemit_permalink)
    end
end
