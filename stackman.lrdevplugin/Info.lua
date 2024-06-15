return {
  VERSION = { major=1, minor=0, revision=0, },

  LrSdkVersion = 13.2,
  LrSdkMinimumVersion = 13.0,

  LrToolkitIdentifier = "com.ashishpandey.stackman",
  LrPluginName = "Stack Manager",
  
  LrPluginInfoProvider = "PluginInfoProvider.lua",
  LrMetadataProvider = 'PluginMetadataDefinition.lua',
  
  LrHelpMenuItems = {
    {
      title = "Clear Plugin Metadata",
      file = "ClearPluginMetadata.lua",
      enabledWhen = "photosSelected",
    },
  },
  
  LrLibraryMenuItems = {
    {
      title = "Label Under Stack",
      file = "LabelStacked.lua",
      enabledWhen = "photosSelected",
    },
    {
      title = "Mark Enhanced Originals",
      file = "MarkEnhancedOriginals.lua",
      enabledWhen = "photosSelected",
    },
  },
}