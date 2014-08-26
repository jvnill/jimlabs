require 'rails_helper'

describe ApplicationHelper do
  describe 'page_title' do
    before { helper.instance_variable_set('@page_title', 'asd') }

    it { expect(helper.page_title).to eq('asd | Jimlabs | Jim Ruther Nill | Ruby on Rails blog and portfolio') }
  end

  describe 'tabbed_link_to' do
    context 'link matches section' do
      before { helper.instance_variable_set('@section', 'foo') }

      let!(:output) { helper.tabbed_link_to('test', '/test', 'foo') }

      it { expect(output).to eq('<li class="current"><a href="/test">{test}</a></li>') }
    end

    context 'link doesnt match section' do
      before { helper.instance_variable_set('@section', 'bar') }

      let!(:output) { helper.tabbed_link_to('test', '/test', 'foo') }

      it { expect(output).to eq('<li><a href="/test">test</a></li>') }
    end
  end

  describe 'meta_tags' do
    let!(:output) { helper.meta_tags }

    it { expect(output).to eq("<meta content=\"Jimlabs | Jim Ruther Nill | Ruby on Rails blog and portfolio\" name=\"title\"></meta><meta content=\"Jim Ruther Nill\" name=\"author\"></meta><meta content=\"Jim Ruther Nill, Jimlabs, Ruby on Rails\" name=\"keywords\"></meta><meta content=\"Jimlabs: Jim Ruther Nill&#39;s Ruby on Rails blog and portfolio\" name=\"description\"></meta>") }
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
