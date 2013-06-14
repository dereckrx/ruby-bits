class Tweet
  attr_accessor :status
  
  def initialize(&block)
    instance_eval(&block) if block_given?
  end

  def say_hi
    puts "Hi"
  end
  
  def say(message) # with block
    puts yield("saying: #{message}")
  end
end

Tweet.new do 
  self.user = "dereck"
  self.status = "Feeling good"
end

t = Tweet.new
tweet.instance_eval do #change self to instance of tweet class
  self.status = "Changing the status value of the instance"
  self.user = "Dereck"
end

Tweet.class_eval do # Change self to Tweet class
  attr_accessor :user # Call 'attr_accessor' method as Tweet class
end

class MethodLogger
  def log_method_call(klass, method_name)
    klass.class_eval do
      alias_method "#{method_name}_original", method_name
      define_method method_name do |*args, &block|
        puts "#{Time.now}: Called #{method_name}"
        send "#{method_name}_original", *args, &block
      end
    end
  end
end

logger = MethodLogger.new
logger.log_method_call(Tweet, :say_hi)
logger.log_method_call(Tweet, :say)

Tweet.new.say_hi
Tweet.new.say("Hello") { |m| m.upcase }