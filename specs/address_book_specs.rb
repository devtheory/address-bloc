RSpec.describe AddressBook do
  context "attributes" do

    it "should respond to entries" do
      book = AddressBook.new
      expect(book).to respond_to(:entries)
    end

    it "should initialize entries as an array" do
      book = AddressBook.new
      expect(book.entries).to be_a(Array)
    end

    it "should intialize entries and an empty array" do
      book = AddressBook.new
      expect(book.entries.size).eql?(0)
    end
  end

  context ".add_entry" do

    it "should add only one entry to the book" do
      book = AddressBook.new
      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')

      expect(book.entries.size).eql?(1)
    end

    it "should add correct info to entries" do
      book = AddressBook.new
      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      new_entry = book.entries[0]

      expect(new_entry.name).eql? 'Ada Lovelace'
      expect(new_entry.phone_number).eql? '010.012.1815'
      expect(new_entry.email).eql? 'augusta.king@lovelace.com'
    end

  end

  context ".remove_entry" do

    it "should remove one entry from the book" do
      book = AddressBook.new
      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      book.add_entry('Mike Lovelace', '010.012.1825', 'mike.king@lovelace.com')
      length_before = book.entries.size
      book.remove_entry("Mike Lovelace")


      expect(book.entries.size).to eq(length_before - 1)

    end
  end
end