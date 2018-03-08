require 'json'

class CoveragesController < ApplicationController
    
    # GET /closest/:id It returns the results using the closest registered locations in the db to the searching address
    def closest
        @coverage = Coverage.near(params[:id], 10, :units => :km, :order => "distance")
        result = Hash.new
        @coverage.each do |c|
            result.reverse_merge!({c.operator => { "2G" => c.g2, "3G" => c.g3, "4G" => c.g4, "distance" => c.distance}})
        end
        render json: result
    end
    
    # GET /all/:id It returns all the results based on the registered locations which are around 10 KM of the searching address 
    def all
        @coverage = Coverage.near(params[:id], 10, :units => :km, :order => "distance")
        #json_response(@coverage)
        result = Array.new
        @coverage.each do |c|
            result.push("Operator" => c.operator, "2G" => c.g2, "3G" => c.g3, "4G" => c.g4, "distance" => c.distance)
        end
        render json: result
    end  
    
end
