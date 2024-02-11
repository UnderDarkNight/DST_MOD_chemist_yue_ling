----------------------------------------------------------------------------------------------------------------------------------
--[[

     
     
]]--
----------------------------------------------------------------------------------------------------------------------------------
local chemist_com_item_use_to = Class(function(self, inst)
    self.inst = inst

    self.DataTable = {}
end,
nil,
{

})



function chemist_com_item_use_to:SetTestFn(fn)
    if type(fn) == "function" then
        self.test_fn = fn
    end
end

function chemist_com_item_use_to:Test(target,doer)
    if self.test_fn then
        return self.test_fn(self.inst,target,doer)
    end
    return false
end

return chemist_com_item_use_to






