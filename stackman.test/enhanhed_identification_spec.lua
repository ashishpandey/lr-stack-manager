local lrMocks = require 'mock_lr_sdk'

package.preload['LrTasks'] = mock(lrMocks.lrTasks)
package.preload['LrDialogs'] = mock(lrMocks.lrDialogs)

package.preload['LrApplication'] = mock({
    activeCatalog = function ()
        return {
            getTargetPhotos = function ()
                return {
                    a = 'b'
                }
            end
        }
    end
})

describe("Working with Stacks", function()
    describe("Identify Enhanced", function()
        it("mark original photo", function()
            print("testing")
            -- local lrTasks = require("LrTasks")
            -- local lrApp = require("LrApplication")

            local meo = require('MarkEnhancedOriginals')
            

            assert.True(1 == 2)
        end)
    end)
end)