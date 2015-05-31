require_relative "entry.rb"

class AddressBook
  attr_accessor :entries

  def initialize
    @entries = []
  end

  def add_entry(name, ph, email)
    index = 0

    @entries.each do |entry|
      if name < entry.name
        break
      end
      index += 1
    end

    @entries.insert(index, Entry.new(name, ph, email))
  end

  def remove_entry(name)
    @entries.each do |entry|
      if entry.name == name
        @entries.delete(entry)
      end
    end
  end
end