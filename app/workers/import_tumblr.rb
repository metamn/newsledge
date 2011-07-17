# Importing items from Tumblr via background jobs
#
# Rules of use: N/A
#
# Source: http://www.tumblr.com/docs/en/api#api_read
#
# 1. Reading through JSON is broken, Tumblr thinks the JSON call is done via JS
#
# 2. Reading through XML is ok but parsing XML is cumbersome 
class ImportTumblr

  @queue = :tumblr_import_queue
  
  def self.perform(id)
    start = Time.now
    msg = "Import job started at #{start.asctime}, "
    puts msg
    
    begin
      import = Import.find(id)
      item_count_before = Item.count
      
      items = import_all import.account.name
      Item.save items, import.account
      
      msg += "it took #{(Time.now - start).round(2).to_s} seconds, "
      msg += "#{(Item.count - item_count_before).to_s} items were imported."
      import.update_attribute :status, 'Success'      
    rescue => e
      msg += "it took #{(Time.now - start).round(2).to_s} seconds, "
      msg += "and it was unsuccessful with error message #{e.message}"
      import.update_attribute :status, 'Failed'  
    end
    import.update_attribute :log, msg
    puts msg    
  end
  
  # Importing all items
  #
  # First imports the latest 200 items
  # Then, in a loop imports all older items.
  #  
  # Returns and array of imported items
  def self.import_all(user)
    imported = import user
    items = imported
    
    while imported.size >= 2   
      last = items.last.id_str
      imported = import_older user, last
      items += imported  
      puts "Imported other #{imported.size} items"
      puts "Import items size now is #{items.size}"
    end
    items
  end
  
  # Updating items
  #
  def self.update(user)
  end
  
  # Using the Tumblr gem to import the first items
  #
  # user - the username to get the posts from
  #
  # Returns a Hash of Tumblr objects
  def self.import(user)
    Tumblr.blog = "#{user}"
    Tumblr::Post.all
  end
  
  # Using the Tumblr gem to import the older items
  #
  # user - the username to get the posts from
  # counter - from where to start importing posts
  #
  # Returns a Hash of Tumblr objects
  def self.import_older(user, counter)
    Tumblr.blog = "#{user}"
    Tumblr::Post.all
  end
end


