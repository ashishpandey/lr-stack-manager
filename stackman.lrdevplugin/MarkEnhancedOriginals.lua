local LrApplication = import 'LrApplication'
local LrDialogs = import 'LrDialogs'
local LrTasks = import 'LrTasks'

local function markEnhancedOriginal (photo)
  local hasEnhahncedCopy = photo:getPropertyForPlugin( _PLUGIN, 'hasEnhahnedCopy')
  if not hasEnhahncedCopy then
    photo:setPropertyForPlugin( _PLUGIN, 'hasEnhahnedCopy', true )
    return 1
  end
  return 0
end

local function baseName(photo)
  local filenameWithExt = photo:getFormattedMetadata("fileName")
  local filename, extension = filenameWithExt:match("^(.+)%.(.+)$")
  return filename
end

local function processPhotos(photos)
  local modifiedCount = 0
  for ix,photo in ipairs(photos) do
    local filename = baseName(photo)
    local originalName = filename:gsub('%-Enhanced%-NR', '')
    if originalName then
      local isInStack = photo:getRawMetadata('isInStackInFolder')
      if isInStack then
        local stackMembers = photo:getRawMetadata('stackInFolderMembers')
        for ix,stackMember in ipairs(stackMembers) do
          local memberName = baseName(stackMember)
          if memberName == originalName then
            -- found an enhanced Original
            LrDialogs.message('Enhanced', string.format('found %q as original for %q', memberName, filename))
            modifiedCount = modifiedCount + markEnhancedOriginal(stackMember)
          end
        end
      end
    else 
      LrDialogs.message('Enhanced', string.format('no %q enhanced from %q', filename, originalName))
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
  catalog:withWriteAccessDo("mark enhanced originals", function()
    modifiedCount = processPhotos(photos)
  end)

  if modifiedCount == 0 then
    LrDialogs.message('Stack Manager', 'All up to date')
  else
    LrDialogs.message('Stack Manager', string.format('%q photos modified in stacks', modifiedCount))
  end

end)