require 'rubygems'
require 'activerecord'
require File.dirname(__FILE__)+'/../lib/is_taggable'
require 'expectations'
require 'test/unit'
require 'shoulda'
require 'logger'
require 'ruby-debug'

ActiveRecord::Base.configurations = {'sqlite3' => {:adapter => 'sqlite3', :database => ':memory:'}}
ActiveRecord::Base.establish_connection('sqlite3')

ActiveRecord::Base.logger = Logger.new(STDERR)
ActiveRecord::Base.logger.level = Logger::WARN

ActiveRecord::Schema.define(:version => 0) do
  create_table :comments do |t|
  end
  
  create_table :posts do |t|
    t.string  :title, :default => ''
  end

  create_table :pages do |t|
    t.string :title, :default => ''
  end
  
  create_table :users do |t|
    t.string :username
  end

  create_table :tags do |t|
    t.string :name, :default => ''
    t.string :kind, :default => '' 
  end

  create_table :taggings do |t|
    t.integer :tag_id

    t.string  :taggable_type, :default => ''
    t.integer :taggable_id
    
    t.integer :user_id
    t.string  :user_type
  end
end

class Post < ActiveRecord::Base
  is_taggable :tags, :languages
end

class Comment < ActiveRecord::Base
  is_taggable
end

class Page < ActiveRecord::Base
  is_taggable :categories, :fixed => true
end

class User < ActiveRecord::Base
  
end
