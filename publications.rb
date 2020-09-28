# Generate Markdown-Version of Publications
#!/usr/bin/env ruby'
require 'bibtex'
require 'citeproc'
require 'csl/styles'
require 'date'

module Jekyll
  class Scholar
    class Latex2 < BibTeX::Filter
      def apply(value)
        value.to_s.gsub(/\\enquote|\\emph|\\-/, "")
      end
    end
  end
end

# Open bibliography
bib = BibTeX.open('sgroth-bibliography.bib').convert(:latex2,:latex)

CSL::Style.root = "csl/"

# Create a new processor with the desired style, # format, and locale.
cp = CiteProc::Processor.new style: 'unknown', format: 'text', locale: 'de'

# sortorder = cp.engine.style.bibliography > 'sort' > 'key'
# puts sortorder
# sortorder[:macro] = 'issued'
# sortorder[:sort] = 'descending'
# puts sortorder

cp.import bib.to_citeproc

# Process entries with keyword "inpreparation"
inpreparation = bib['@*[keywords~=pre]'].reverse_each.map do |e|
  "* #{cp.render(:bibliography, id: e.key)[0]}"
end

# Process entries with keyword "monography"
monography = bib['@book[keywords!=notaccepted  && keywords!=miszelle &&  keywords!=pre && keywords=monography]'].reverse_each.map do |e|
  "* #{cp.render(:bibliography, id: e.key)[0]}"
end

# Process entries with keyword "editedvolume"
editedvolume = bib['@*[keywords ^= editedvolume && keywords !~ notaccepted && keywords!~pre]'].reverse_each.map do |e|
  "* #{cp.render(:bibliography, id: e.key)[0]}"
end

# Process entries with keyword "specialissue"
specialissue = bib['@periodical'].reverse_each.map do |e|
  "* #{cp.render(:bibliography, id: e.key)[0]}"
end

# Process peer reviewed articles
peerreviewedarticle = bib['@article[keywords!~ notaccepted && keywords^=peerreview && keywords!~pre]'].reverse_each.map do |e|
  "* #{cp.render(:bibliography, id: e.key)[0]}"
end

# Process other articles
article = bib['@article[ keywords!~ peerreview && keywords!~ notaccepted && keywords!~pre]'].reverse_each.map do |e|
  "* #{cp.render(:bibliography, id: e.key)[0]}"
end

# Process incollection
incollection = bib['@incollection[keywords!~ pre && keywords!=miszelle && keywords!=notaccepted]'].reverse_each.map do |e|
  "* #{cp.render(:bibliography, id: e.key)[0]}"
end

# Process entries with keyword "miszelle"
miszelle = bib['@*[keywords=miszelle]'].reverse_each.map do |e|
  "* #{cp.render(:bibliography, id: e.key)[0]}"
end

# Process entries with keyword "review"
review = bib['@review[keywords!=dev]'].reverse_each.map do |e|
  "* #{cp.render(:bibliography, id: e.key)[0]}"
end

date = Time.new
current_time = date.year.to_s + "-" + date.month.to_s + "-" + date.day.to_s 

# Write to output file
File.open( 'publications.de.md', "w" ) do |file|
  file.puts "# Schriftenverzeichnis\nDr. Stefan Groth  \n[https://www.stefangroth.com](https://www.stefangroth.com)\n\n"
  file.puts "Version: " + current_time + "\n\n## Beiträge im Erscheinen und in Vorbereitung"
  file.puts inpreparation.join("  \n")
  file.puts "\n## Monographien"
  file.puts monography.join("  \n")
  file.puts "\n## Herausgeberschaften"
  file.puts editedvolume.join("  \n")
  file.puts "\n## Sondernummern von Zeitschriften"
  file.puts specialissue.join("  \n")
  file.puts "\n## Peer Reviewed Papers"
  file.puts peerreviewedarticle.join("  \n")
  file.puts "\n## Zeitschriftenaufsätze"
  file.puts article.join("  \n")
  file.puts "\n## Aufsätze in Sammelbänden"
  file.puts incollection.join("  \n")
  file.puts "\n## Miszellen"
  file.puts miszelle.join("  \n")
  file.puts "\n## Rezensionen"
  file.puts review.join("  \n")
end
