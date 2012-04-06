class CreateCampagneTables < ActiveRecord::Migration

  def change
    create_table :campagne_contacts do |t|
      t.string   :email      
      t.string   :name
      t.timestamps
    end
    create_table :campagne_lists do |t|
      t.string   :name
      t.timestamps
    end
    create_table :campagne_contacts_campagne_lists, :id => false do |t|
      t.integer  :campagne_contact_id
      t.integer  :campagne_list_id
      t.timestamps
    end
    create_table :campagne_campaigns do |t|
      t.string   :name
      t.string   :subject
      t.text     :body, :limit => 2147483647
      t.timestamps
    end
    create_table :campagne_campaigns_campagne_lists, :id => false do |t|
      t.integer  :campagne_campaign_id
      t.integer  :campagne_list_id
      t.timestamps
    end
    create_table :campagne_deliveries do |t|
      t.integer  :campagne_campaign_id
      t.integer  :campagne_contact_id
      t.integer  :campagne_list_id
      t.string   :email
      t.string   :token
      t.datetime :seen_at
      t.datetime :clicked_at
      t.datetime :unsubscribed_at
      t.datetime :bounced_at
      t.string   :ip_address
      t.string   :user_agent
      t.timestamps
    end
    add_index "campagne_deliveries", ["token"], :name => "index_deliveries_on_token", :unique => true
    add_index "campagne_campaigns_campagne_lists", ["campagne_campaign_id", "campagne_list_id"], :name => "index_campaigns_lists_on_c_and_l", :unique => true
    add_index "campagne_contacts_campagne_lists", ["campagne_contact_id", "campagne_list_id"], :name => "index_contacts_lists_on_c_and_l", :unique => true
  end

end
