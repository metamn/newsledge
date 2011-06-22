class Importer
  include ActionView::Helpers::DateHelper

  @queue = :import_queue
  
  def self.perform(id)
    start = Time.now
    msg = "Import job started at #{start.asctime}, "
    puts msg
    begin
      import = Import.find(id)
      msg += "it took #{(Time.now - start).to_s} seconds, "
      msg += "x items were imported."
      import.update_attribute :status, 'success'      
    rescue => e
      msg += "it took #{(Time.now - start).to_s} seconds, "
      msg += "and it was unsuccessful with error message #{e.message}"
      import.update_attribute :status, 'failed'  
    end
    import.update_attribute :log, msg
    puts msg    
  end
end


