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
    CSV.read('./db/gossip.csv').each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end

  def self.find(id)
    CSV.read('./db/gossip.csv')[id.to_i]
  end

  def self.update(id, gossip_author, gossip_content)
    all_gossips = CSV.read('./db/gossip.csv')
    gossip_to_update = all_gossips[id.to_i]
    gossip_to_update[0] = gossip_author
    gossip_to_update[1] = gossip_content
    CSV.open('./db/gossip.csv', 'wb') { |csv| all_gossips.each{|row| csv << row}}
  end

end

