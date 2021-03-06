require 'redcarpet'

class NoParagraphRenderer < ::Redcarpet::Render::XHTML
  def paragraph(text)
    text
  end    
end

AutoHtml.add_filter(:soundcloud_og).with({:alt => ''}) do |text, options|
	alt = options[:alt]
	r = Redcarpet::Markdown.new(NoParagraphRenderer)
	text.gsub(/(https?):\/\/(www.)?soundcloud\.com\//) do
		p = HTTParty.get(text)
		s = p.to_s
		a = s.rindex('og:image')
		b = a-13
		img = []
		while s[b] != '"' do
			img << s[b]
			b = b - 1
		end
    	r.render("![#{alt}](#{img.reverse.join})")
    end
end