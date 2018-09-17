-- The main function is the first function called from Iguana.
--------------------------------------------------------------------------|
--- List of configurations:                                               |
--- Database path         (stored in shared module)                       |
--- Database filename     (stored in shared module)                       | 
--- groupName                                                             |
--- serverTypeGROUPNAME   (store in environment variable)                 |
--------------------------------------------------------------------------|

local dbUtil  = require('dbUtil')
local conn = dbUtil.init() -- Establish DB connection at channel start

function main(Data)
   
   -- (1) Parise incoming data
   local jsonTbl = json.parse{data=Data}
   
   -- (2) Insert data into database
   dbUtil.insert(jsonTbl,conn)
   
end
