require '/home/ashley/dev-stuff/ruby-stuff/api.rb'
slapi = Authapi.new

# display last five closed ticket IDs and Titles
# two aspects to check for are 'title' and 'id'
begin
ticket_service = SoftLayer::Service.new("SoftLayer_Account",
	:username => slapi.name,
	:api_key => slapi.key)
tickets = ticket_service.getLastFiveClosedTickets
tickets.each do |ticketlist|
print "Ticket - #{ticketlist["id"]} - #{ticketlist["title"]}\n"
end
rescue Exception => exception
	puts "Unable to list the last 5 closed tickets; Exception thrown: #{exception}"
end

# read in user inputted ticket ID number to get the last ticket update
begin
gathered_tickets = SoftLayer::Service.new("SoftLayer_Ticket",
	:username => slapi.name,
	:api_key => slapi.key)
puts "Please input Ticket ID Number: "
ticketid = gets.chomp.to_i
ticket_ref = gathered_tickets.object_with_id(ticketid)
updates = ticket_ref.getUpdates
pp updates
rescue Exception => exception
	puts "Unable to gather ticket update; Exception throw: #{exception}"
end
