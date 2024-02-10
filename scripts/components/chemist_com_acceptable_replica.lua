----------------------------------------------------------------------------------------------------------------------------------
--[[

     
     
]]--
----------------------------------------------------------------------------------------------------------------------------------
local chemist_com_acceptable = Class(function(self, inst)
    self.inst = inst

    self.DataTable = {}
end,
nil,
{

})

function chemist_com_acceptable:SetTestFn(fn)
    if type(fn) == "function" then
        self.Test_Fn = fn
    end
end

function chemist_com_acceptable:Test(item,doer)
    if self.Test_Fn then
        return self.Test_Fn(self.inst,item,doer)
    end
    return false
end

return chemist_com_acceptable






