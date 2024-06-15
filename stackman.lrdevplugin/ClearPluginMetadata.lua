local LrApplication = import 'LrApplication'
local LrDialogs = import 'LrDialogs'
local LrTasks = import 'LrTasks'

local function processPhotos(photos)
  local modifiedCount = 0
  for pIx,photo in ipairs(photos) do
    local underStack = photo:getPropertyForPlugin(_PLUGIN, 'underStack')
    if underStack then
      photo:setPropertyForPlugin(_PLUGIN, 'underStack', nil)
      modifiedCount = modifiedCount + 1
    end
    local hasEnhahnedCopy = photo:getPropertyForPlugin(_PLUGIN, 'hasEnhahnedCopy')
    if hasEnhahnedCopy then
      photo:setPropertyForPlugin(_PLUGIN, 'hasEnhahnedCopy', nil)
      modifiedCount = modifiedCount + 1
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
  catalog:withWriteAccessDo("clear metadata", function()
    modifiedCount = processPhotos(photos)
  end)

  if modifiedCount == 0 then
    LrDialogs.message('Stack Manager', 'Found no plugin metadata')
  else
    LrDialogs.message('Stack Manager', string.format('cleared %q plugin metadata fields', modifiedCount))
  end

end)