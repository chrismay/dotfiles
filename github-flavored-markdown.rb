#!/usr/bin/env ruby
# Processor for Github flavored markdown, inspired by:
# https://github.com/alampros/Docter/blob/master/bin/github-flavored-markdown.rb
#
# Current version of this script can be found here:
# https://gist.github.com/1300939
#
# Adapted for Redcarpet version 2 by Ralph von der Heyden
# http://github.com/ralph
# http://twitter.com/ralph
# http://www.rvdh.de
#
# You will need the following gems:
# * redcarpet version 2
# * albino
#
# You also need the pygments library for syntax highlighting:
# sudo easy_install pygments
# Make sure the pygmentize bin is in your $PATH, or link it like that:
# sudo ln -s /usr/local/bin/pygmentize /usr/bin
#
# Make sure to chmod +x this script.
#
# Usage:
# github-flavored-markdown.rb document.md

require 'rubygems'
require 'redcarpet'
require 'albino'

class SyntaxRenderer < Redcarpet::Render::HTML
  def block_code(code, language)
    if language && !language.empty?
      Albino.colorize(code, language)
    else
      "<pre><code>#{code}</code></pre>"
    end
  end
end

def markdown(text)
  renderer = SyntaxRenderer.new(optionize [
    :with_toc_data,
    :hard_wrap,
    :xhtml
  ])
  markdown = Redcarpet::Markdown.new(renderer, optionize([
    :fenced_code_blocks,
    :no_intra_emphasis,
    :tables,
    :autolink,
    :strikethrough,
    :space_after_headers
  ]))
  markdown.render(preprocess(text))
end

def optionize(options)
  options.inject({}) { |memo, option| memo[option] = true; memo }
end

def preprocess(text)
  jira_links(v1_links(text))
end
def v1_links(text)
    text.gsub(/([DIS]-[0-9]+)/,'[\1](http://versionone/VersionOne/Search.mvc/advanced?q=\1)')
end
def jira_links(text)
    text.gsub(/([A-Z]{3,4}-[0-9]+)/,'[\1](https://jira.blackpepper.co.uk/browse/\1)')
end



puts markdown(ARGF.read)
