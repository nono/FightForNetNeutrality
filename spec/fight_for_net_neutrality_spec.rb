#!/usr/bin/env ruby

require "minitest/autorun"
require "rack/mock"
require "fight_for_net_neutrality"


describe FightForNetNeutrality do
  app = lambda {|env| [200, {"Content-Type" => "text/plain"}, ["Foobar"] ] }
  req = Rack::MockRequest.new(FightForNetNeutrality.new(app))

  it "doesn't modify authorized request" do
    res = req.get("/", "REMOTE_ADDR" => "127.0.0.2")
    res.status.must_equal 200
    res.body.must_equal "Foobar"
  end

  it "blocks unauthorized access" do
    res = req.get("/", "REMOTE_ADDR" => "62.160.71.50")
    res.status.must_equal 403
    res.body.must_include "Ressource inaccessible"
  end

  it "blocks proxified unauthorized access" do
    res = req.get("/", "REMOTE_ADDR" => "127.0.0.1", "HTTP_X_FORWARDED_FOR" => "62.160.71.50")
    res.status.must_equal 403
    res.body.must_include "Ressource inaccessible"
  end

  it "blocks OpenOffice.org firewall" do
    res = req.get("/", "REMOTE_ADDR" => "127.0.0.2", "HTTP_X_FIREWALL" => "OpenOffice.org")
    res.status.must_equal 403
    res.body.must_include "Ressource inaccessible"
  end
end
