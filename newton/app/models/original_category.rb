class OriginalCategory < ActiveRecord::Base
  include Mongoid::Document
  
  field :name
  field :source
end
