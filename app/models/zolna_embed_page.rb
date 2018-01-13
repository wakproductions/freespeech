class ZolnaEmbedPage < ApplicationRecord
  scope :in_post_queue, -> { postable.where(in_post_queue: true) }
  scope :postable, -> { where(do_not_repost: [false, nil], steemit_post_response: nil).order(:created_at, :id) }

  def self.postable_next(record)
    ar_id = ZolnaEmbedPage.arel_table[:id]
    ar_created_at = ZolnaEmbedPage.arel_table[:created_at]
    postable.where(in_post_queue:[false,nil]).where(ar_id.gt(record.id), ar_created_at.gt(record.created_at))
  end

  def add_tag(*tags)
    update(additional_tags: ((additional_tags.split(',').any? ? additional_tags.split(',') : []) + tags).join(','))
  end

  def add_to_queue
    update(in_post_queue: true, do_not_repost: nil)
  end

  def skip_posting
    update(do_not_repost: true)
  end

end
