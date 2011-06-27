# A list of platforms Newsledge can import data from
# All platforms must have an open API to make reading data possible
#
# name - The name of the platform
# description - What users should know about this platform
#
# Examples
#
#  Platform.new :name => 'twitter', :description => 'Allows only 200 items to be read at once....' 
class Platform < ActiveRecord::Base
  validates_uniqueness_of :name
  
  has_many :accounts
  
  # Adding the import job to the queue
  #
  # Each platform has its own worker
  #
  # import_id - The ID of the Import which will be updated
  def import(import_id)
    case self.name
    when 'Twitter'
      Resque.enqueue(ImportTwitter, import_id)
    end
  end
end
