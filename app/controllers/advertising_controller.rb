class AdvertisingController < ApplicationController
require 'open-uri'
require 'json'
require "base64"

######
## To-do:
## Iterate through Chartboost array, creating a Hash of each Hash with Date. This allows it to be linked up to the appfigures data.
## Basically: format chartboost data in the same way.

  def index
    @appfigures = self.appfigures
    @chartboost = self.chartboost
    #@money_spent = 0
    
    
    # @chartboost.sort_by {|day| day['Date']}.each do |key|
     #   selected_date = key['Date'].to_s
     #   money_spent = key['Money Spent'].scan(/[.0-9]/).join().to_f
     #   money_earned = key['Money Earned'].scan(/[.0-9]/).join().to_f
        
     #   profit = @appfigures[selected_date]['revenue'].to_f + money_earned - money_spent
     #   profit = profit.to_s
        
     #   p key['Date'] + ' Revenue: $' + @appfigures[selected_date]['revenue'] + ' Spent: '+  key['Money Spent'] + ' CB Rev: '+  key['Money Earned'] + ' Profit: $' + profit
      #end
      
      @appfigures.sort.each do |date, value|
        puts value['date'] + value['revenue']
        puts @chartboost[2]['Money Spent']
      end

  end
  

  def appfigures
  #Last 30 days appfigures sales
  base_uri = 'https://api.appfigures.com/v2/sales/dates/-30/0/?client_key=c4d602e22c264ef5a9661041f605ba0e'
  secret_key = '2536a77e2dd34389bac17c2f6b667ac2'
  username = 'josh@minomonsters.com'
  password = 'Brywok100'
  auth = 'Basic ' + Base64.encode64(username + ':' + password)
  
  #Json Hash of results
  @appfigures = JSON.parse(open(base_uri, "Authorization" => auth).read)
 
  @total_revenue = 0
  @total_downloads = 0
  
  ####################
   #@appfigures.sort.each do |date, value|
        #value['net_downloads'] 
        #puts "#{date}-----"
        #p value['net_downloads'] 
        #p value['revenue'] 
     
        #@total_revenue = @total_revenue + value['revenue'].to_i
       # @total_downloads = @total_downloads + value['net_downloads']
    #end
   # p 'Total revenue: $' + @total_revenue.to_s + ' Total downloads:' + @total_downloads.to_s
   return @appfigures
  end

  def chartboost
    start_date = Date.today.ago(30.days).to_date.to_s
    end_date = Date.today.to_s
    
    chartboost = 'http://api.chartboost.com/analytics/apps?date_min=' + start_date + '&date_max=' + end_date + '&user_id=4f302e43cd1cb26927000018&user_signature=587602f86a81119a61b919295eb40449b9a2f8ac'
     @chartboost = JSON.parse (open(chartboost).read)
     #@money_spent = 0
     
     #@chartboost.sort_by {|day| day['Date']}.each do |key|
       # p key['Date'] + ' ' + key['Money Spent']
       # digit = key['Money Spent'].scan(/[.0-9]/).join().to_f
      # @money_spent = @money_spent + digit
      # end
    #p @money_spent
    return @chartboost
  end
  
  def tapjoy
      tapjoy = 'https://api.tapjoy.com/reporting_data.json?email=josh%40minomonsters.com&api_key=75e7de847acb4af394d9fcd330c9c394&date=2013-09-01'    
  end
  
end