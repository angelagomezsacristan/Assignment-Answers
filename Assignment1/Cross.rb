#!/usr/bin/env ruby
#NOTE: This script was made in collaboration with Ana Karina Ballesteros Gomez, Mariam El Akal Chaji and Marta Fernandez Gonzalez.

class Cross
#The attributes we defined and initialized.
#A variable was created in order to contain the file information. 
  attr_accessor :parent1
  attr_accessor :parent2
  attr_accessor :f2_w
  attr_accessor :f2_p1
  attr_accessor :f2_p2
  attr_accessor :f2_p1p2

  @@data = {}
  
  def initialize (
      thisparent1, 
      thisparent2, 
      thisf2_w,
      thisf2_p1,
      thisf2_p2,
      thisf2_p1p2) 

      @parent1 = thisparent1
      @parent2 = thisparent2
      @f2_w = thisf2_w
      @f2_p1 = thisf2_p1
      @f2_p2 = thisf2_p2
      @f2_p1p2 = thisf2_p1p2
  end
  
  #We read the cross_data.tsv file and put its information in the data variable @@data.
  def self.file_cross (filename)
    file = CSV.read(filename, headers: true, col_sep: "\t")
    i = 0
    file.each do |row|
      @@data[i] = Cross.new(row[0], row[1], row[2], row[3], row[4], row[5])
      i = i+1
    end 
    return @@data
  end
  
  #We defined the chisq function in order to analyse the linkage between the different genes.
  #This function has three arguments: data, with the file information; dictionary, with the hash 
  #(seed_stock => gene_id); and dictionary2, with the hash (gene_id => gene_name).
  def self.chisq (data, dictionary, dictionary2)
    @Final_report = []
    @vector = []
    (0..4).each do |n|
      total_individuals = data[n].f2_w.to_f + data[n].f2_p1.to_f + data[n].f2_p2.to_f + data[n].f2_p1p2.to_f
      chisQ = ((data[n].f2_w.to_i - (total_individuals*9/16))**2)/(total_individuals*9/16) + ((data[n].f2_p1.to_i - (total_individuals*3/16))**2)/(total_individuals*3/16) + ((data[n].f2_p2.to_i - (total_individuals*3/16))**2)/(total_individuals*3/16) + ((data[n].f2_p1p2.to_i - (total_individuals*1/16))**2)/(total_individuals*1/16)
      
      #The chisQ value is the table chi-square value, this value was obtained for a p-value = 0.05 and 
      #with three freedom degrees (4 phenotypes -1). In order to have linkage the observed chi-square has to be
      #higher than the chisQ value.

      if chisQ > 7.815
        s = 0
        var1  = dictionary["#{data[n].parent1}"]
        var2 = dictionary2["#{var1}"]
        var3  = dictionary["#{data[n].parent2}"]
        var4 = dictionary2["#{var3}"]
        puts "Recording: #{var2} is genetically linked to #{var4} with chisquare score #{chisQ}"
        @Final_report = @Final_report.append("#{var2} is linked to #{var4}")
        @Final_report = @Final_report.append("#{var4} is linked to #{var2}")
        @vector[s] =  [var2, var4, chisQ]
        s = s+1
    
      end
    end
    puts
    puts
    puts "Final report:"
    puts @Final_report
    return @vector
end 
end  