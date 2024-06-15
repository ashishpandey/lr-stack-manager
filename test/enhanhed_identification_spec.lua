local lrMocks = require 'mock_lr_sdk'

mock_imports['LrTasks'] = mock(lrMocks.lrTasks)
mock_imports['LrDialogs'] = mock(lrMocks.lrDialogs)

mock_imports['LrApplication'] = mock({
    activeCatalog = function ()
        return {
            getTargetPhotos = function ()
                return {
                    a = 'b'
                }
            end,

            withWriteAccessDo = function (_, _, work)
                work()
            end
        }
    end
})

describe("Working with Stacks", function()
    describe("Identify Enhanced", function()
        it("mark original photo", function()
            print("testing")
            require('MarkEnhancedOriginals')

            assert.True(1 == 1)
        end)
    end)
end)