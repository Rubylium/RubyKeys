# RubyKeys
Simple key system for FiveM servers


# How to give a key ?
Use this trigger event:
```
TriggerEvent("RS_KEY:GiveKey", plate)
```
plate = The plate of the vehicles ... Yeah i'm serious.
**This is a client event, if you call it server side use TriggerClientEvent**
