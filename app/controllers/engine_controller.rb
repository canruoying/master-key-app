class EngineController < ApplicationController
  def index
    @password_types = ['normal', 'long', 'simple', 'pin']
    @master_key = params[:master_key]
    @service = params[:service]
    @email = params[:email]
    @counter = params[:counter]
    @password_type = params[:password_type]
    @hint = ''

    template_set = case @password_type
    when 'normal'
      @@template_normal
    when 'long'
      @@template_long
    when 'simple'
      @@template_simple
    when 'pin'
      @@template_pin
    end

    if @service.nil? || @service == '' || @email.nil? || @email == '' || @master_key.nil? || @master_key == '' || @counter.nil? || @counter == ''
       @hint = "Your generated password will appear here after filling out all
       fields above and clicking the generate button. No information
       will be stored."
    else
      start_time = Time.now
      @service = @service.downcase
      @email = @email.downcase
      @salt = "#{@service}#{@email}#{@counter}"
      @password = Generator.generate(@master_key, @salt, template_set)
      @elapsed_time = (Time.now - start_time) * 1000
      if @password.nil?
        @hint = "This was not supposed to happen... Debug info: #{@password_type} | #{@service} |
         #{@email} | #{@master_key.length} | #{@counter}."
      else
        @hint = "Generated a #{@password_type} type password for #{@service} with username
         #{@email} and a length #{@master_key.length} master key. The counter is at #{@counter}.
         Algorithm runtime: #{@elapsed_time.round(2)} ms."
      end
    end
  end

  @@template_normal = Array.new(16)
  @@template_simple = Array.new(16)
  @@template_long = Array.new(16)
  @@template_pin = Array.new(1)

  @@template_normal[0] = 'aAnxaaAxsa'
  @@template_normal[1] = 'nanAxsxaAn'
  @@template_normal[2] = 'aAaAsnnxaa'
  @@template_normal[3] = 'xaAxnsaAnx'
  @@template_normal[4] = 'naxsaaAxAn'
  @@template_normal[5] = 'aAAaxAxsnx'
  @@template_normal[6] = 'nAAaxsaxxA'
  @@template_normal[7] = 'AsxAaxaxnA'
  @@template_normal[8] = 'naAxansAas'
  @@template_normal[9] = 'axsnAaAaxx'
  @@template_normal[10] = 'AasxnnxaAn'
  @@template_normal[11] = 'xAnAxaasxa'
  @@template_normal[12] = 'axsaxnaAAx'
  @@template_normal[13] = 'xAaaAxsxan'
  @@template_normal[14] = 'AsxnAAaxAx'
  @@template_normal[15] = 'aasAAnaxnx'

  @@template_simple[0] = 'aAnnanAn'
  @@template_simple[1] = 'nnaanAAn'
  @@template_simple[2] = 'AnnaAnAA'
  @@template_simple[3] = 'nnAnaanA'
  @@template_simple[4] = 'aAaaanAn'
  @@template_simple[5] = 'nnaannnn'
  @@template_simple[6] = 'nnAaanAA'
  @@template_simple[7] = 'nAAnaanA'
  @@template_simple[8] = 'aAaaanAa'
  @@template_simple[9] = 'aaaanAAn'
  @@template_simple[10] = 'AnAAaaan'
  @@template_simple[11] = 'AAAnaanA'
  @@template_simple[12] = 'aAaAnnAn'
  @@template_simple[13] = 'nAAaaaAn'
  @@template_simple[14] = 'anAaAnAA'
  @@template_simple[15] = 'AAAAaann'

  @@template_long[0] = 'xaxAxxnsxxxxxxx'
  @@template_long[1] = 'xxxxxxxxsxAnaxx'
  @@template_long[2] = 'xxxnxAxaxsxxxxx'
  @@template_long[3] = 'xsxAxxxxxxxxaxn'
  @@template_long[4] = 'xxxxxAxsxaxnxxx'
  @@template_long[5] = 'xxsxAxxnxxaxxxx'
  @@template_long[6] = 'xxxxxxAsxxnxxxa'
  @@template_long[7] = 'xsAxnxxxxxxxaxx'
  @@template_long[8] = 'xxxxxnxxsxxAxax'
  @@template_long[9] = 'xxxnsxxxxxAxaxx'
  @@template_long[10] = 'xxAxxxxnxxsxAxx'
  @@template_long[11] = 'xxxxxxnxxxxAxas'
  @@template_long[12] = 'xxxxAxsxxxnxaxx'
  @@template_long[13] = 'xxxxxxxAxnxsxax'
  @@template_long[14] = 'Ansxxxaxxxxxxxx'
  @@template_long[15] = 'xxnsxAxxaxxxxxx'

  @@template_pin[0] = 'nnnn'

end
