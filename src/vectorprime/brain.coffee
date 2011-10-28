Url   = require "url"
Redis = require "redis"

class Brain
  constructor: () ->
    info   = Url.parse process.env.REDISTOGO_URL || 'redis://localhost:6379'
    @client = Redis.createClient(info.port, info.hostname)
    @db_name = process.env.VECTORPRIME_DBNAME || ""
  
  dbify: (str) ->
    @db_name + "|" + str
  
  hset: (hash, key, value, cb) ->
    @client.hset @dbify(hash), key, value, cb
  
  hget: (hash, key, cb) ->
    @client.hget @dbify(hash), key, cb
  
  hdel: (hash, key, cb) ->
    @client.hdel @dbify(hash), key, cb

  hkeys: (hash, cb) ->
    @client.hkeys @dbify(hash), cb
  
  hincrby: (hash, key, amount, cb) -> 
    @client.hincrby @dbify(hash), key, amount, cb
  
  hgetall: (hash, cb) ->
    @client.hgetall @dbify(hash), cb  

module.exports = Brain
