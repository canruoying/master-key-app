class EngineController < ApplicationController
  def index
    @password_types = ['normal', 'long', 'simple', 'pin']
    @master_key = params[:master_key]
    @service = params[:service]
    @email = params[:email]
    @counter = params[:counter]
    @password_type = params[:password_type]
    @salt = "#{@service}#{@email}#{@counter}"

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

    @password = Generator.generate(@master_key, @salt, template_set)

    if @password.nil?
      @hint = "Your generated password will appear here after filling out all
       fields above and clicking the generate button. No information
       will be stored."
    else
      @hint = "Generated a #{@password_type} type password for #{@service} with email address
       #{@email} and a length #{@master_key.length} master key. The counter is at #{@counter}."
    end
  end

  @@template_normal = Array.new(16)
  @@template_simple = Array.new(16)
  @@template_long = Array.new(16)
  @@template_pin = Array.new(1)

  @@template_normal[0] = 'aAnsxxxxxx'
  @@template_normal[1] = 'xaxAnsxxxx'
  @@template_normal[2] = 'xxaAxxnsxx'
  @@template_normal[3] = 'xaAxxsxxnx'
  @@template_normal[4] = 'xaxsxxAxxn'
  @@template_normal[5] = 'xxxaxAxsnx'
  @@template_normal[6] = 'nxxaxsxxxA'
  @@template_normal[7] = 'xsxAxxaxnx'
  @@template_normal[8] = 'naxxxxxAxs'
  @@template_normal[9] = 'axsnAxxxxx'
  @@template_normal[10] = 'xxsxxxxaAn'
  @@template_normal[11] = 'xxnAxxasxx'
  @@template_normal[12] = 'axsxxNxxAx'
  @@template_normal[13] = 'xxxaAxsxxn'
  @@template_normal[14] = 'xsxNxxaxAx'
  @@template_normal[15] = 'xxsxAxaxnx'

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
