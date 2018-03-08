Rails.application.routes.draw do
    get '/closest/:id', to: 'coverages#closest'
    
    get '/all/:id', to: 'coverages#all'
end
