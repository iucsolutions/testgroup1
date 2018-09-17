-- The main function is the first function called from Iguana.
-- The Data argument will contain the message to be processed.

--------------------------------------------------------------------------|
--- List of configurations:                                               |
--- csv path              (stored in shared module)                       |
--- csv filename          (stored in shared module)                       | 
--- groupName                                                             |
--- serverTypeGROUPNAME   (stored in environment variable)                |
--------------------------------------------------------------------------|

local csvUtil = require('csvUtil')

function main(Data)
   
   -- (1) Parse incoming information
   local jsonTbl = json.parse{data=Data}
   
   -- (2) Update the csv file
   csvUtil.updateFile(jsonTbl)
   
end