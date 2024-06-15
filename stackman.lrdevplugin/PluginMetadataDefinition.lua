return {
  schemaVersion = 1,
  metadataFieldsForPhotos = {
    {
      id = 'underStack',
      title = 'Under Stack',
      dataType = 'enum',
      values = {
        {
          title = "yes",
          value = true
        },
        {
          title = "no",
          value = nil
        },
        allowPluginToSetOtherValues = false
      },
      readOnly = true,
      searchable = true,
      browsable = true,
    },
    {
      id = 'hasEnhahnedCopy',
      title = 'Has Enhanced Copy',
      dataType = 'enum',
      values = {
        {
          title = "yes",
          value = true
        },
        {
          title = "no",
          value = nil
        },
        allowPluginToSetOtherValues = false
      },
      readOnly = true,
      searchable = true,
      browsable = true,
    },
  },
}