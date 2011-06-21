class Importer
  @queue = :import_queue
  def self.perform(id)
    puts "Importer started"
  end
end


