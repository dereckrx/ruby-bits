TweetStruct = Struct.new(:user, :status) do
  def to_s
    "#{user}: #{status}"
  end
end

class Tweet
  states = [:draft, :posted, :deleted] # instead of writing three methods
  states.each do |status|
    define_method status do |params, &block|# or any string method
      # array.each(&block)
      @status = status
    end
  end
  # alias :current_method :new_method # No comma
  # obj.public_send(:public_method) # only try public methods
  # obj.method(:method_name).call(params)
end