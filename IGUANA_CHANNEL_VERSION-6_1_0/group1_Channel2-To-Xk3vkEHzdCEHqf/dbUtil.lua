local iucConf = require('IUCConfigsgroup1')
local mapDB = {}

-- Initiate database connection
function mapDB.init() 
	local conn = db.connect{api=db.SQLITE,
      name = iucConf.patientDbPath..iucConf.patientDbFile}
   return conn
end

-- Create PatientData table 
function mapDB.createTable(conn) 
	local sql = [[CREATE TABLE 'PatientData'
                      ('PatientId' INTEGER, 
                       'sex' TEXT,
                       'FirstName' TEXT,
                       'LastName'  TEXT,
                       'DateOfBirth'  TEXT,
                       'SSN' INTEGER,
                        PRIMARY KEY(PatientId));]]
   conn:execute{sql=sql,live=true}
   return sql
end

-- Check if the 'PatientData' table exists in the supplied db connection
-- handle. 
-- Returns true if table exists, false if not
function mapDB.checkTable(conn) 
   local sql = [[SELECT name FROM sqlite_master WHERE type='table'
                             AND name='PatientData']]
   local result = conn:query{sql=sql,live=true}
   return not result[1]:isNull()
end

-- Insert the patient data in jsonTbl into database. If table does not 
-- previously exist, it'll create a new one before inserting. 
function mapDB.insert(jsonTbl,conn) 
   local exists = mapDB.checkTable(conn)
   
   if not exists then mapDB.createTable(conn) end
   
   local sqlStm = [[INSERT OR REPLACE INTO PatientData VALUES (']]..
      jsonTbl['patientId'].."','" ..jsonTbl['sex'].."','"..jsonTbl['firstName']..
      "','"..jsonTbl['lastName'].."','"..jsonTbl['dob'].."','"..jsonTbl['ssn'].."')"
      
   conn:execute{sql=sqlStm,live=true}
end

return mapDB