local LrApplication = import 'LrApplication'
local LrDialogs = import 'LrDialogs'
local LrTasks = import 'LrTasks'

local function processPhoto (photo)
  local filename = photo:getFormattedMetadata("fileName")
  local stackPosition = photo:getRawMetadata('stackPositionInFolder')
  local shouldBeUnderStack = stackPosition > 1
  local isUnderStack = photo:getPropertyForPlugin( _PLUGIN, 'underStack')
  -- LrDialogs.message('Stack Manager', string.format('%q is under stack = %q', filename, isUnderStack))
  if isUnderStack ~= shouldBeUnderStack then
    -- mismatch, so update
    if shouldBeUnderStack then
      photo:setPropertyForPlugin( _PLUGIN, 'underStack', true )
    else
      photo:setPropertyForPlugin( _PLUGIN, 'underStack', nil )
    end
    return 1
  end
  return 0
end

local function processPhotos(photos)
  local modifiedCount = 0
  for ix,photo in ipairs(photos) do
    local isInStack = photo:getRawMetadata('isInStackInFolder')
    local isStackCollapsed = photo:getRawMetadata('stackInFolderIsCollapsed')
    if isInStack and isStackCollapsed then
      local stackMembers = photo:getRawMetadata('stackInFolderMembers')
      for stackIx = 1, #stackMembers do
        modifiedCount = modifiedCount + processPhoto(stackMembers[stackIx])
      end
    else
      modifiedCount = modifiedCount + processPhoto(photo)
    end
  end
  return modifiedCount
end

LrTasks.startAsyncTask(function ()
  local catalog = LrApplication.activeCatalog()

  local photos = catalog:getTargetPhotos()
  if photos == nil then
    return
  end
  
  local modifiedCount = 0
  catalog:withWriteAccessDo("label stacks", function()
    modifiedCount = processPhotos(photos)
  end)

  if modifiedCount == 0 then
    LrDialogs.message('Stack Manager', 'All up to date')
  else
    LrDialogs.message('Stack Manager', string.format('%q photos modified in stacks', modifiedCount))
  end

end)