require "csv"

keywords_path = Rails.root.join("db/seeds/keywords.csv")

if keywords_path.exist?
  imported_count = 0

  CSV.foreach(keywords_path, headers: true) do |row|
    word = row["word"].to_s.strip
    next if word.blank?

    keyword = Keyword.find_or_initialize_by(word: word)
    keyword.reading = row["reading"].to_s.strip.presence
    keyword.pos = row["pos"].to_s.strip.presence
    keyword.category = row["category"].to_s.strip
    keyword.len = row["len"].presence&.to_i
    keyword.save!

    imported_count += 1
  end

  puts "Imported #{imported_count} keywords from #{keywords_path}"
else
  puts "No keywords file found: #{keywords_path}"
end
