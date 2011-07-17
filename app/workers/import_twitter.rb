# Importing items from Twitter via background jobs
#
# Rules of use:
#
# Source: http://dev.twitter.com/pages/api_terms
#
# 1. If you will eventually need more than 5 million user tokens for your projects, 
# you will need to talk to us directly about access to the Twitter API.
# 
# 2. If you provide an API that returns Twitter data, you may only return IDs (including tweet IDs and user IDs).
#
# 3. You may export or extract non-programmatic, GUI-driven Twitter Content as a PDF or spreadsheet by using "save as" 
# or similar functionality.
#
# 4. Exporting Twitter Content to a datastore as a service or other cloud based service, however, is not permitted.
#
# Source: http://dev.twitter.com/pages/display_guidelines
#
# 5. Displaying tweets must follow the above guideline
#
# Source: http://dev.twitter.com/pages/rate-limiting
#
# 6. Unauthenticated calls are permitted 150 requests per hour
# Unauthenticated calls are measured against the public facing IP of the server or device making the request.
# 
# 7. Rate limits are applied to methods that request information with the HTTP GET command
#
# 8. Clients may access a theoretical maximum of 3,200 statuses via the page and count parameters for the 
# user_timeline REST API methods. 
# Other timeline methods have a theoretical maximum of 800 statuses
#
# Source: http://dev.twitter.com/doc/get/statuses/user_timeline
#
# 9. Authentication is required if either user_id or screen_name are not supplied, 
# or the user specified by user_id or screen_name is protected. 
# If the specified user has protected their account their timeline is only visible if the authenticating 
# user is a follower.
#
# 10. If Authentication is used the rate limit goes up to 350 request/hour
#
# 11. Parameters to use:
#
# since_id - Returns results with an ID greater than (that is, more recent than) the specified ID
# max_id - Returns results with an ID less than (that is, older than) or equal to the specified ID. 
# count - Specifies the number of tweets to try and retrieve, up to a maximum of 200
#
# 12. To retreive all 3200 tweets 3200/200 = 16 API calls are necessary
#
# 13. In worst case 150/16 ~= 10 users / hour can be retrieved
#
# 14. There will be two types of twitter calls:
# 
# get_all - Returns all tweets (max 3200)
# get_recent - Returns latest tweets since the inital import.
#
# 15. get_recent must not be scheduleable. It would take too much API calls. Instead the user should initiate
# an update on the UI.
# 
# 16. User initiated updates must be limited. Perhaps we must leave ~ 16-48 API calls for new users, the
# rest can be spent on updates
class ImportTwitter

  @queue = :twitter_import_queue
  
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
  
  # Using the Twitter gem to import the first items
  #
  # user - the username to get the timeline
  #
  # Returns an array of Twitter objects
  def self.import(user)
    Twitter.user_timeline("#{user}", :count => 200, :include_rts => true, :include_entities => true) 
  end
  
  # Using the Twitter gem to import the older items
  #
  # user - the username to get the timeline
  # counter - from where to start importing tweets
  #
  # Returns an array of Twitter objects
  def self.import_older(user, counter)
    Twitter.user_timeline("#{user}", :max_id => counter, :count => 200, :include_rts => true, :include_entities => true) 
  end
end


