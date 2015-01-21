require 'rails_helper'

describe ApplicationHelper do
  describe 'page_title' do
    before { helper.instance_variable_set('@page_title', 'asd') }

    it { expect(helper.page_title).to eq('asd | Jimlabs | Jim Ruther Nill | Ruby on Rails blog and portfolio') }
  end

  describe 'waypoint_path' do
    context 'controller is pages' do
      it { expect(helper.waypoint_path('test')).to eq('/#test') }
    end

    context 'controller is not pages' do
      before { allow(helper).to receive(:controller_name).and_return('pages') }

      it { expect(helper.waypoint_path('test')).to eq('#test') }
    end
  end

  describe 'meta_tags' do
    let!(:output) { helper.meta_tags }

    it { expect(output).to match("content=\"Jimlabs | Jim Ruther Nill | Ruby on Rails blog and portfolio\"") }
    it { expect(output).to match("content=\"Jim Ruther Nill\"") }
    it { expect(output).to match("content=\"Jim Ruther Nill, Jimlabs, Ruby on Rails\"") }
    it { expect(output).to match("content=\"Jimlabs: Jim Ruther Nill&#39;s Ruby on Rails blog and portfolio\"") }
  end

  describe 'form_div' do
    context 'block not passed' do
      it { expect(helper.form_div(Post.new, :id)).to be_nil }
    end

    context 'object has errors' do
      let!(:output) do
        post = Post.new
        post.valid?

        helper.form_div(post, :title, class: 'test') do
          helper.content_tag(:li, 'foo')
        end
      end

      it { expect(output).to eq('<div class="test error"><li>foo</li></div>') }
    end

    context 'object has no errors' do
      let!(:post) { create(:post) }

      let!(:output) do
        helper.form_div(post, :title, class: 'test') do
          helper.content_tag(:li, 'foo')
        end
      end

      it { expect(output).to eq('<div class="test"><li>foo</li></div>') }
    end
  end

  describe 'markdown' do
    let!(:output) { helper.markdown('`test`') }

    it { expect(output).to eq("<p><code>test</code></p>\n") }
  end

  describe 'tag_links' do
    let!(:post)   { create(:post, tag_list: 'foo, bar') }
    let!(:output) { helper.tag_links(post) }

    it { expect(output).to eq('<a class="tag" href="/tags/foo">foo</a>, <a class="tag" href="/tags/bar">bar</a>') }
  end

  describe 'years_experience' do
    it { expect(helper.years_experience).to match(/\d{1,2} years( \d{1,2} months)/) }
  end
end
