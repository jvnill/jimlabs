require 'rails_helper'

describe Post do
  describe '.for_year' do
    let!(:post1) { create(:post, created_at: 1.year.ago) }
    let!(:post2) { create(:post, created_at: Time.now) }

    it { expect(Post.for_year(Time.now.year).to_a).to eq([post2]) }
  end

  describe '.count_by_year' do
    let!(:post1) { create(:post, created_at: 1.year.ago) }
    let!(:post2) { create(:post, created_at: Time.now) }

    it { expect(Post.count_by_year).to eq(Time.now.year => 1, 1.year.ago.year => 1) }
  end

  describe '.meta_tags' do
    let!(:post1) { create(:post) }
    let!(:post2) { create(:post, published: false) }

    it { expect(Post.meta_tags).to eq([post1.tag_list]) }
  end

  describe '.meta_desc' do
    let!(:post1) { create(:post) }
    let!(:post2) { create(:post, published: false) }

    it { expect(Post.meta_desc).to eq([post1.title]) }
  end

  describe '#to_param' do
    let!(:post) { create(:post) }

    it { expect(post.to_param).to eq(post.path) }
  end

  describe '#set_path' do
    let!(:title) { '9&^AIDH&U@*&K@Bikd&WIDU' }
    let!(:post) { create(:post, title: title, path: nil) }

    it { expect(post.path).to eq(title.parameterize) }
  end
end
