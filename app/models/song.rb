class Song < ActiveRecord::Base
  # add associations here
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def artist_name=(name)
    artist = Artist.find_or_create_by(name: name)
    self.artist_id = artist.id
  end

  def artist_name
    self.artist ? self.artist.name : nil
  end

  def note_contents=(contents)
    contents.each do |content|
      if !content.strip.empty?
        note = Note.create(content: content)
        self.notes << note
        # note.song_id = self.id
        # self.notes.build(content:content)
      end
    end
  end

  def note_contents
    self.notes.map { |note| note.content }
  end
end
