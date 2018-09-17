local dbConfigs = {}

local groupName = 'GROUPNAME'    -- Enter group name here
local dbPath = '/home/centos/iuc/centralDB/'..groupName..'/'
local dbName = 'Channel1.sqlite'

-- Initiate database connection
function dbConfigs.init() 
	local conn = db.connect{api=db.SQLITE,name = dbPath..dbName}
   return conn
end

-- Query the webAPI table in database to find config values
-- associated with this instance. 
-- This instance is retrieved from an environment variable 
-- 'serverTypeGROUPNAME'
-- Returns webAPI URL and webAPI URL Page (webURL,webPage)
function dbConfigs.retrieve() 
   local conn = dbConfigs.init()
   local envVariable = 'serverType'..groupName
   local instance = os.getenv(envVariable)
   local webInfo = conn:query("select * FROM 'webAPI' WHERE Instance='"..instance.."'")
   local webURL = webInfo[1].URL:nodeValue()
   local webPage = webInfo[1].ChannelName:nodeValue()
   conn:close()
   return webURL,webPage
end

return dbConfigs