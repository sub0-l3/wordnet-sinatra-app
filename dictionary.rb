require 'sinatra'

set :bind, '0.0.0.0'

get '/meaning' do
  # matches "GET /meaning?word=magic"
  word = params[:word]	
  cmd = "/usr/local/WordNet-3.0/bin/wn #{word} -over" 
  %x[ #{cmd} ]
end