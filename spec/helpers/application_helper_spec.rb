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

      it { expect(output).to eq('<a class="current" href="/test">{test}</a>') }
    end

    context 'link doesnt match section' do
      before { helper.instance_variable_set('@section', 'bar') }

      let!(:output) { helper.tabbed_link_to('test', '/test', 'foo') }

      it { expect(output).to eq('<a href="/test">test</a>') }
    end
  end

  describe 'meta_tags' do
    let!(:output) { helper.meta_tags }

    it { expect(output).to eq("<meta content=\"Jimlabs | Jim Ruther Nill | Ruby on Rails blog and portfolio\" name=\"title\"></meta><meta content=\"Jim Ruther Nill\" name=\"author\"></meta><meta content=\"Jim Ruther Nill, Jimlabs, Ruby on Rails\" name=\"keywords\"></meta><meta content=\"Jimlabs: Jim Ruther Nill&#39;s Ruby on Rails blog and portfolio\" name=\"description\"></meta>") }
  end

  describe 'form_div' do
    pending
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
end
