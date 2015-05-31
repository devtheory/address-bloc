require_relative "../models/address_book.rb"

class MenuController
  attr_accessor :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu
    puts "Main Menu - #{@address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - Create an entry"
    puts "3 - Search for an entry"
    puts "4 - Import entries from a CSV"
    puts "5 - View entry number _"
    puts "6 - Exit"
    print "Enter your selection: "

    selection = gets.to_i
    
    case selection
    when 1
      system "clear"
      view_all_entries
      main_menu
    when 2
      system "clear"
      create_entry
      main_menu
    when 3
      system "clear"
      search_entries
      main_menu
    when 4
      system "clear"
      read_csv
      main_menu
    when 5
      system "clear"
      print "Enter the number for the entry you want to see: "
      entry_num = gets.to_i
      view_entry(entry_num)
      main_menu
    when 6
      puts "Good bye!"
      exit(0)
    else
      puts "Invalid input. Try again"
      main_menu
    end
  end

  def view_all_entries
    @address_book.entries.each do |entry|
      system "clear"
      puts entry.to_s

      entry_submenu(entry)
    end

    system "clear"
    puts "End of entries"
  end

  def create_entry
    system "clear"

    puts "Add new entry"

    print "Name: "
    name = gets

    print "Phone number: "
    phone = gets

    print "Email: "
    email = gets

    @address_book.add_entry(name, phone, email)

    system "clear"
    puts "New Entry created"
  end

  def search_entries
    
  end

  def read_csv
    
  end

  def view_entry(entry)
    system "clear"
    return puts "There are no entries in your address book" if @address_book.entries.size == 0
    pulled_entry = @address_book.entries[entry].to_s

    while entry >= @address_book.entries.size 
      puts "You need a valid entry ID. Please try again..."
      print "Enter an ID number to pull the entry: "
      entry = gets.to_i
      pulled_entry = @address_book.entries[entry].to_s
    end
    puts pulled_entry

    # system "clear"
    main_menu
  end

  def entry_submenu(entry)
    puts "n - next entry"
    puts "d - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"

    # #17
    selection = gets.chomp

    case selection
    # #18
      when "n"
    # #19
      when "d"
      when "e"
    # #20
      when "m"
        system "clear"
        main_menu
    else
      system "clear"
      puts "#{selection} is not a valid input"
      entries_submenu(entry)
    end
  end
end