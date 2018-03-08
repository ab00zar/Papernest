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
end
