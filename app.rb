#!/usr/bin/env ruby -I ../lib -I lib
# coding: utf-8

require 'bundler/setup'
Bundler.require

require 'sinatra'
require 'sinatra/json'
require 'sinatra/reloader'
require 'sinatra/cross_origin'
require "sinatra/jsonp"

# Build and parse Redis uri
redis_uri = URI.parse(ENV["REDISTOGO_URL"] || "redis://localhost:6379")

# Make connection to Redis
set :redis, Redis.new(
  host: redis_uri.host,
  port: redis_uri.port,
  password: redis_uri.password
)

# Set server and connection pool
set server: 'thin', connections: []

# Headers
set :allow_origin, :any
set :allow_methods, [:get, :post, :options]
set :allow_credentials, true
set :max_age, "1728000"

# Allow CORS
set :protection, except: :http_origin

# Models
require_relative 'app/models/resource'

# Controllers
require_relative 'app/controllers/base_controller'
require_relative 'app/controllers/resource_controller'


