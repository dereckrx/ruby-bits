# DSL class starts here
def tweet_as(user, text=nil, &block)
  tweet = Tweet.new(user)
  tweet.text(text) if text
  tweet.instance_eval(&block) if block_given?
  tweet.submit_to_twitter
end

# Normal classes
class Tweet
  def initialize(user)
    @user = user
    @tweet = []
    @annotations = {}
  end
  
  def submit_to_twitter
    tweet_text = @tweet.join(",")
    if tweet_text.length > 140
      raise "Tweet text is too long"
    end
    puts "#{@user}: #{tweet_text}"
    puts @annotations.inspect unless @annotations.empty?
    self
  end
  
  def text(str)
    @tweet << str
    self
  end
  
  def hashtag(hash)
    @tweet << "##{hash}"
    self
  end
  
  def link(l)
    @tweet << l
    self
  end
  
  def mention(*users)
    users.each {|user| @tweet << "@#{user}" }
    self
  end
  
  def method_missing(name, *args)
    if args.empty?
      name.to_s
    else
      @annotations[name] = args.join(', ')
    end
  end
end

# DSL starts here
tweet_as "dereckrx" do
  mention 'codeschool', 'matt'
  text("Hello from dsl").hashtag('horray').mention("ratsark")
  lat 212.12
  long 20
  yo_dawg "Hella", "vanilla"
  ice_cream hella, vanilla
end

tweet_as "ratsark", "Rats are kewl"