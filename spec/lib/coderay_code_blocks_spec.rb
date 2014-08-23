require 'rails_helper'

describe CoderayCodeBlocks do
  describe '#block_code' do
    let!(:code_block) { CoderayCodeBlocks.new }

    it { expect(code_block.block_code('`asd`', 'ruby')).to eq("<div class='header'>ruby</div><div class=\"CodeRay\">\n  <div class=\"code\"><pre><span class=\"shell\"><span class=\"delimiter\">`</span><span class=\"content\">asd</span><span class=\"delimiter\">`</span></span></pre></div>\n</div>\n") }
  end
end
