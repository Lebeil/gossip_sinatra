require 'bundler'
Bundler.require

class Gossip
  attr_accessor :author, :content

  def initialize(author, content)
    @author = author
    @content = content
  end

  def save
    CSV.open('./db/gossip.csv', 'ab') do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end

  def self.find(id)
    CSV.read("./db/gossip.csv")[id.to_i]
  end

  def self.edit(id)
    Gossip.find(params['id'])
    CSV.open('./db/gossip.csv', 'ab') do |csv|
      csv << [@author, @content, id]
    end

  end

end

