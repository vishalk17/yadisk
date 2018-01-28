require 'yadisk/client'

RSpec.describe Yadisk::Client do
  it "#new" do
    yadisk = Yadisk::Client.new(login: "my_awesome_name",
			       	password: "my_awesome_password")
    expect(yadisk).not_to be_nil
  end
  it "has #new with block" do
    yadisk = Yadisk::Client.new do |client|
      client.login = "my_awesome_name"
      client.password = "my_awesome_password"
    end
    expect(yadisk).not_to be_nil
  end
end
