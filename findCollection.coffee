mongo = require 'mongodb'
dbServer = new mongo.Server "127.0.0.1", 27017, {}
client = new mongo.Db 'kangou', dbServer, {w:1}


#listOfBikerPosition = ()->

orderList = (dbErr, collection) ->
    console.log "Unable to access database: #{dbErr}" if dbErr
      collection.find().nextObject(err, result) ->
        if err
          console.log "Unable to find record: #{err}"
        else
          console.log result
          client.close()


client.open (err, database) ->
  client.collection 'order', orderList

console.log orderList
