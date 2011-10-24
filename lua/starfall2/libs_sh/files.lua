local files_library = {}
--- File functions. Allows modification of files.
-- @shared
SF.Libraries.Register("files",files_library)

--- Access Files permission
-- @name Access Files Permission
-- @class table
-- @field name "Access Files"
-- @field desc "Allows access to data/StarfallScriptData/"
-- @field level 1
-- @field value True if clientside, false if serverside

SF.Permissions:registerPermission({
	name = "Access Files",
	desc = "Allows access to data/StarfallScriptData/",
	level = 1,
	value = CLIENT,
})

file.CreateDir("StarfallScriptData/")

--- Reads a file from path
-- @param path Filepath relative to data/StarfallScriptData/. Cannot contain '..'
-- @return Contents, or nil if error
-- @return Error message if applicable
function files_library.read(path)
	if path:find("..",1,true) then return nil, "path contains '..'" end
	if not SF.instance.permissions:checkPermission("Access Files") then return nil, "access denied" end
	local contents = file.Read("StarfallScriptData/"..path)
	if contents then return contents else return nil, "file not found" end
end

--- Writes to a file
-- @param path Filepath relative to data/StarfallScriptData/. Cannot contain '..'
-- @return True if OK, nil if error
-- @return Error message if applicable
function files_library.write(path)
	if path:find("..",1,true) then return nil, "path contains '..'" end
	if not SF.instance.permissions:checkPermission("Access Files") then return nil, "access denied" end
	file.Write("StarfallScriptData/"..path)
	return true
end

--- Checks if a file exists
-- @param path Filepath relative to data/StarfallScriptData/. Cannot contain '..'
-- @return True if exists, false if not, nil if error
-- @return Error message if applicable
function files_library.exists(path)
	if path:find("..",1,true) then return nil, "path contains '..'" end
	if not SF.instance.permissions:checkPermission("Access Files") then return nil, "access denied" end
	return file.Exists(path)
end

--- Deletes a file
-- @param path Filepath relative to data/StarfallScriptData/. Cannot contain '..'
-- @return True if successful, nil if error
-- @return Error message if applicable
function files_library.delete(path)
	if path:find("..",1,true) then return nil, "path contains '..'" end
	if not SF.instance.permissions:checkPermission("Access Files") then return nil, "access denied" end
	if not file.Exists(path) then return nil, "doesn't exist" end
	file.Delete(path)
	return true
end
