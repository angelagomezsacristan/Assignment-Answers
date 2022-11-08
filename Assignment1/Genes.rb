#!/usr/bin/env ruby
#NOTE: This script was made in collaboration with Ana Karina Ballesteros Gomez, Mariam El Akal Chaji and Marta Fernandez Gonzalez.


class Genes
#The attributes we defined and initialized. 
#Two variables were created in order to contain the file information and the hash(dictionary created with the gene id and the gene name).
  attr_accessor :genes_id
  attr_accessor :gene_name
  attr_accessor :mutant_phe
  attr_accessor :linkage
  attr_accessor :linked_genes
  
  @@genes_data={}
  @@genes_id ={}
  
  def initialize (genes_ID, gene_names, mutants_phenotype)
    @genes_id =  genes_ID
    @gene_name = gene_names
    @mutant_phe = mutants_phenotype
    @@genes_id[genes_ID] = gene_names #creating a hash
    @linked_genes = ''
  end 
  
  #We read the gene_information.tsv file and put its information in the data variable @@genes_data.
  def self.file_gene(filename)
    
    genes_info = CSV.read(filename, col_sep: "\t", headers: true)
    i=0
    genes_info.each do |gene|
      @@genes_data[i] = Genes.new(gene[0], gene[1], gene[2])
      i = i+1
    end
    return @@genes_data
  end 
  
  #We use a describe function to try if the information has been read properly.
  def self.describe(gene)
    puts gene.genes_id
    puts gene.gene_name
    puts gene.mutant_phe
  end

  #We  generated the dictionary with the gene id and the gene name.
  def self.update_hash(data)
    @@genes_id.each do |data|
      data
    end
  end

  #We defined a function which allows us to find the gene information by typing its ID
  #in the following way --> Genes.find_gene_by_id("gene id").
  def self.find_gene_by_id(id) #Find gene by ID
    @@genes_data.each do |gene|
      if gene[1].genes_id == id
        return gene[1]
      end
    end
  end 

  #We create a linkage vector in order to have the information about the genes dependence as an attribute.
  def self.linkage(vector)
    vector.each do |row|
      (0..4).each do |gene|
        if @@genes_data[gene].gene_name == "#{row[0]}"
          @@genes_data[gene].linked_genes = row[1], row[2]
        end
        if @@genes_data[gene].gene_name == "#{row[1]}"
          @@genes_data[gene].linked_genes = row[0], row[2]
        end
      end
    end
  end
end 