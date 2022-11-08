#!/usr/bin/env ruby
#NOTE: This script was made in collaboration with Ana Karina Ballesteros Gomez, Mariam El Akal Chaji and Marta Fernandez Gonzalez.


require "csv"
require "date"
require './Genes.rb'
require './SeedStock.rb'
require './Cross.rb'

#Control of arguments
if ARGV.length() != 3
    abort("WARNING! I expected 3 arguments, check your arguments")
end 

#In order to simulate the plantation we read the Seed file and create the different objects
my_Seeds = Seed.reading_file(ARGV[1])

#After reading the file, we simulate the plantation and obtain the following output:
puts "Plantation in process..."
puts
Seed.plantation()

#First of all we are going to design hashes
dictionary = Seed.update_hash(my_Seeds)

#In addition, we create a new dataset with the updated information
Seed.gen_new_table()

#We read the the Genes file
my_Genes = Genes.file_gene(ARGV[0])

#First of all we are going to design hashes
dictionary2 = Genes.update_hash(my_Genes)

#Once we have done the plantation and generated the new dataset, we are going to study the linkage of the different genes
#First of all, we read the Cross file and create objects in order to do our analysis
data_cross = Cross.file_cross(ARGV[2])
puts

#We are going to study the genes linkage by calling our chi-square function (previously defined in the Cross object):
Cross.chisq(data_cross, dictionary, dictionary2)