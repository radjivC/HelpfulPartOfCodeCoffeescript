# updateCollectionMongoDB.coffee
#
# created by Radjiv Carrere
# 6 octobre 2014
#
# License MIT
#


mongo = require 'mongodb'

server = new mongo.Server "127.0.0.1", 27017, {}

client = new mongo.Db 'rainbowZoo', server, {w:1}



client.open (err, database) ->
      client.collection 'unicorn', unicorn

unicorn = (dbErr, collection) ->
  console.log "Unable to access database: #{dbErr}" if dbErr
  collection.update({ _id:'2122129'},{'$set':{'status':'hungry'}}, (err, result) ->
    if err
      console.log "Unable to find record: #{err}"
    else
      console.log result
    client.close()
    )
