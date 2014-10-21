# createNewCollection.coffee
#
# created by Radjiv Carrere
# 6 octobre 2014
#
# License MIT
#

mongo = require 'mongodb'

server = new mongo.Server "127.0.0.1", 27017, {}

client = new mongo.Db 'rainbowZoo', server, {w:1}

# save() updates existing records or inserts new ones as needed
unicorn = (dbErr, collection) ->
    console.log "Unable to access database: #{dbErr}" if dbErr
    collection.save {
      #this is a new collection
      "_id": "2122129",
      "name":"charlie",
      "birthday": "02/10/2010",
      "status":"sleepy"

    }, (err, docs) ->
        console.log "Unable to save record: #{err}" if err
        client.close()

#put your collection in the database
client.open (err, database) ->
    client.collection 'unicorn', unicorn

console.log "new unicorn"
