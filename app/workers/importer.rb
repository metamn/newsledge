class Importer

  @queue = :import_queue
  
  def self.perform(id)
    start = Time.now
    msg = "Import job started at #{start.asctime}, "
    puts msg
    
    begin
      import = Import.find(id)
      msg += "it took #{(Time.now - start).round(2).to_s} seconds, "
      msg += "x items were imported."
      import.update_attribute :status, 'Success'      
    rescue => e
      msg += "it took #{(Time.now - start).round(2).to_s} seconds, "
      msg += "and it was unsuccessful with error message #{e.message}"
      import.update_attribute :status, 'Failed'  
    end
    import.update_attribute :log, msg
    puts msg    
  end
end


