require "rails_helper"

RSpec.describe "Event Dashboard", type: :feature do
  let(:category1) { create(:category) }
  let(:user) { create(:user) }
  let!(:event) { create(:event, title: "Folk Festival", date: "#{Time.now + 4.day.to_i}", category_id: category1.id, user_id: user.id) }
  let(:ticket) { create(:ticket, title: "VIP", price: 100, event_id: event.id) }
  let(:ticket2) { create(:ticket, title: "GA", price: 250, event_id: event.id) }

  before do
    FactoryBot.create_list(:purchased_ticket, 10, user_id: user.id, event_id: event.id, ticket_id: ticket.id )
    FactoryBot.create_list(:purchased_ticket, 10, user_id: user.id, event_id: event.id, ticket_id: ticket2.id )
    sign_in_user(user)
    visit event_dashboard_index_path(event, key: event.event_guid)
  end

  it "should show event dashboard page" do 
    expect(page.text).to include("#{event.title} Dashboard")
  end

  it "should show sales volume" do 
    expect(page.text).to include("Sales Volume")
    expect(page.text).to include("$3,500.00")
  end 

  it "should show tickets sold" do
    expect(page.text).to include("Tickets Sold")
    expect(page.text).to include("20")
  end 

  it "should show time remaining" do 
    expect(page.text).to include("Time Remaining")
    expect(page.text).to include("4 days")
  end 
end 