#!/usr/bin/env ruby
#NOTE: This script was made in collaboration with Ana Karina Ballesteros Gomez, Mariam El Akal Chaji and Marta Fernandez Gonzalez.


class Seed
#First of all, the attributes were defined and initialized. 
#Three variables were created in order to contain the file information, the file header and the hash (dictionary created with stock id and mutant gene ID).
    attr_accessor :stock
    attr_accessor :mtgid
    attr_accessor :dataplanted
    attr_accessor :storage
    attr_accessor :gramsremain
  
    @@data = {}
    @@headers = {}
    @@seed_id = {}
    
    def initialize (
        thisstock, 
        thismtgid, 
        thisdataplanted,
        thisstorage,
        thisgramsremain) # get a name from the "new" call, or set a default
  
        @stock = thisstock
        @mtgid = thismtgid
        @dataplanted = thisdataplanted
        @storage = thisstorage
        @gramsremain = thisgramsremain
        @@seed_id[stock] = thismtgid #creating a hash
    end
    
    #We read the seed_stock_data.tsv file and put its information in the data variable @@data.
    def self.reading_file (filename)
      file = CSV.read(filename, headers: true, col_sep: "\t")
      @@headers = file.headers
      i = 0
      file.each do |row|
        @@data[i] = Seed.new(row[0], row[1], row[2], row[3], row[4])
        i = i+1
      end 
      return @@data
    end

  #We use a describe function to try if the information has been read properly.
    def self.describe(seed)
      puts seed.stock
      puts seed.mtgid
      puts seed.dataplanted
      puts seed.storage
      puts seed.gramsremain
    end

   #We generated the dictionary with the seed stock and the mutant gene id.
    def self.update_hash(data)
      @@seed_id.each do |data|
        data[1]
      end
    end 

    #We created a plantation function in order to simulate the plantation, 7 seeds of each seed stock
    #were planted and the number of remaining frams were updated. The plantation date was also updated.
    def self.plantation ()
      (0..4).each do |n|
        numer_seeds = @@data[n].gramsremain.to_i
        if numer_seeds > 7
          @@data[n].gramsremain = numer_seeds - 7
          @@data[n].dataplanted = DateTime.now.strftime('%-d/%-m/%Y')
        elsif numer_seeds <= 7
          @@data[n].gramsremain = 0
          @@data[n].dataplanted = DateTime.now.strftime('%-d/%-m/%Y')
          puts ("WARNING!! We have run out of Seed Stock #{@@data[n].stock}")
        end
        
      end
      puts ("Plantation done")
  end
    
  #We created a new file called new_stock_file.tsv which contains the seed stock data updated after
  #the plantation.
    def self.gen_new_table()
      File.open("new_stock_file.tsv", "w") { |f| f.write "" }
      @@headers.each do |header|
        File.open("new_stock_file.tsv", "a") { |f| f.write "#{header}\t" }
      end
      File.open("new_stock_file.tsv", "a") { |f| f.write "\n" }
      (0..4).each do |n|
        File.open("new_stock_file.tsv", "a") { |f| f.write "#{@@data[n].stock}\t#{@@data[n].mtgid}\t#{@@data[n].dataplanted}\t#{@@data[n].storage}\t#{@@data[n].gramsremain}\n" }      
      end
    end

  #We defined a function which allows us to find the seed information by typing its ID
  #in the following way --> Seed.find_seed_by_id("stock_id")
    def self.find_seed_by_id(id) #Find seed by ID
    @@data.each do |seed|
      if seed[1].stock == id
        return seed[1]
      end
    end
  end  
end