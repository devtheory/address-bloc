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
    name = gets.chomp

    print "Phone number: "
    phone = gets.chomp

    print "Email: "
    email = gets.chomp

    @address_book.add_entry(name, phone, email)

    system "clear"
    puts "New Entry created"
  end

  def search_entries
    print "Search by name: "
    name = gets.chomp
    match = @address_book.binary_search(name)
    system "clear"

    if match
      puts match.to_s
      search_submenu(match)
    else
      puts "No match found."
    end
  end

  def read_csv
    print "Enter CSV filename to import: "

    filename = gets.chomp

    if filename.empty?
      system "clear"
      puts "No CSV file to read"
      main_menu
    end

    begin
      entry_count = @address_book.import_from_csv(filename)
      system "clear"
      puts "#{entry_count} entries added from #{filename}"
    rescue
      puts "#{filename} is not a valid CSV file. Please enter the name of a valid CVS file "
      read_csv
    end
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
        delete_entry(entry)
      when "e"
        edit_entry(entry)
        entry_submenu(entry)
    # #20
      when "m"
        system "clear"
        main_menu
    else
      system "clear"
      puts "#{selection} is not a valid input"
      entry_submenu(entry)
    end
  end

  def delete_entry(entry)
    @address_book.entries.delete(entry)
    puts "#{entry.name} has been deleted."
  end

  def edit_entry(entry)
    print "Updated name: "
    name = gets.chomp

    print "Updated number: "
    number = gets.chomp

    print "Updated email: "
    email = gets.chomp

    entry.name = name if !name.empty?
    entry.phone_number = number if !number.empty?
    entry.email = email if !email.empty?

    system "clear"

    puts "Updated entry: "
    puts entry
  end

  def search_submenu(entry)
    puts "\nd - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"
    # #13
    selection = gets.chomp

    # #14
    case selection
      when "d"
        system "clear"
        delete_entry(entry)
        main_menu
      when "e"
        edit_entry(entry)
        system "clear"
        main_menu
      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selection} is not a valid input"
        puts entry.to_s
        search_submenu(entry)
    end
  end
end