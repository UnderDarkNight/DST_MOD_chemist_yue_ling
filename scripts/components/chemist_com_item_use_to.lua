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



function chemist_com_item_use_to:SetActiveFn(fn)
    if type(fn) == "function" then
        self.acive_fn = fn
    end
end

function chemist_com_item_use_to:Active(target,doer)
    if self.acive_fn then
        return self.acive_fn(self.inst,target,doer)
    end
    return false
end

return chemist_com_item_use_to






