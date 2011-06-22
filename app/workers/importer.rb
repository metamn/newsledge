class Importer
  @queue = :import_queue
  def self.perform(id)
    puts "Importer started for #{id}"
    import = Import.find(id)
    import.update_attribute :log, "Importer started for #{id}"
    puts "ok"
  end
end


