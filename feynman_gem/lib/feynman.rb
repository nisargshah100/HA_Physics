require "feynman/version"
require "faraday"
require "json"

module Feynman
  class Client
    def initialize(options={})
      options[:url] ||= "http://feynman.dev/api/v1"
      @conn = Faraday.new(:url => options[:url])

      if token = options[:token]
        @token = token
      end
      @options = options

    end

    def create_event(display_name, body)
      resp = @conn.post do |req|
        req.url "/events.json"
        req.params['token'] = @token
        req.params['event'] = JSON.dump(body)
        req.headers['Content-Type'] = 'application/json'
      end
      [resp.status, resp.body]
    end

  #   def get_feed(display_name)
  #     resp = @conn.get do |req|
  #       req.url "/feeds/#{display_name}.json"
  #       req.params['token'] = @token
  #       req.headers['Content-Type'] = 'application/json'
  #     end
  #     [resp.status, resp.body]
  #   end

  #   def create_link_item(display_name, link_url, comment=nil)
  #     attr_hash = {:type=> "LinkItem", :link_url => link_url}
  #     attr_hash[:comment] = comment if comment

  #     resp = @conn.post do |req|
  #       req.url "/feeds/#{display_name}/items.json"
  #       req.params['token'] = @token
  #       req.params['body'] = JSON.dump(attr_hash)
  #       req.headers['Content-Type'] = 'application/json'
  #     end
  #     [resp.status, resp.body]
  #   end

  #   def create_twitter_item(display_name, tweet_json)
  #     tweet_hash = JSON.parse(tweet_json)
  #     body_json = JSON.dump({type: "TwitterItem", tweet: tweet_hash})
  #     resp = @conn.post do |req|
  #       req.url "/feeds/#{display_name}/items.json"
  #       req.params['token'] = @token
  #       req.params['body'] = body_json
  #       req.headers['Content-Type'] = 'application/json'
  #     end
  #     [resp.status, resp.body]
  #   end

  #   def create_instagram_item(display_name, upload_json)
  #     instagram_hash = JSON.parse(upload_json)
  #     body_json = JSON.dump({type: "InstagramItem", image: instagram_hash})

  #     resp = @conn.post do |req|
  #       req.url "/feeds/#{display_name}/items.json"
  #       req.params['token'] = @token
  #       req.params['body'] = body_json
  #       req.headers['Content-Type'] = 'application/json'
  #     end
  #     [resp.status, resp.body]
  #   end

  #   def user_recent_stream_items(display_name, last_stream_item_id)
  #     resp = @conn.get do |req|
  #       req.url "/feeds/#{display_name}/since/#{last_stream_item_id}.json"
  #       req.params['token'] = @token
  #       req.headers['Content-Type'] = 'application/json'
  #     end
  #     [resp.status, resp.body]

  #   end

  #   def retrout_item(display_name, item_id)
  #     resp = @conn.post do |req|
  #       req.url "/feeds/#{display_name}/stream_items/#{item_id}/refeeds.json"
  #       req.params['token'] = @token
  #       req.headers['Content-Type'] = 'application/json'
  #       puts req
  #     end
  #     [resp.status, resp.body]
  #   end
  # end
end