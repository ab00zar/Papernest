Rails.application.routes.draw do
    get '/closest/:id', to: 'coverages#closest'
end
