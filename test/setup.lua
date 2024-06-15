_G.mock_imports = {}

_G.import = function (module_name)
    print('importing mocked', module_name)
    return mock_imports[module_name]
end

_G.resetMocks = function ()
    mock_imports = {}
end