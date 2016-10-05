class EngineController < ApplicationController
  def index
    @master_key = params[:master_key]
    @service = params[:service]
    @email = params[:email]
    @counter = params[:counter]
    @salt = "#{@service}#{@email}#{@counter}"
    @password = Generator.generate(@master_key, @salt)
    if @password.nil?
      @hint = "Your password will appear here after filling out all
       fields above and clicking the Request button."
    else
      @hint = "\##{@counter} password generated for #{@service} using
       email=#{@email} and a length #{@master_key.length} master key."
    end
  end
end
