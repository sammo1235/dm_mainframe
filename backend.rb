module Backend
  def self.enroll_all_users
    Dir.glob("./enrollment.rb").each {|file| load file }
    puts "Enrolled All Users!"
    $USERS.each do |user|
      puts "#{user.name}, #{user.sex}, #{user.age}, #{user.likes}"
    end
  end

  class << self
    private
    def allow_definition
      Kernel.send(:define_method, "define_user") do |name, &block|
        User.build_user(name, &block)
      end
    end
  end
end

