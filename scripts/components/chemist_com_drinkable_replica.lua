----------------------------------------------------------------------------------------------------------------------------------
--[[

     
     
]]--
----------------------------------------------------------------------------------------------------------------------------------
local chemist_com_drinkable = Class(function(self, inst)
    self.inst = inst

    self.DataTable = {}
end,
nil,
{

})



function chemist_com_drinkable:SetTestFn(fn)
    if type(fn) == "function" then
        self.test_fn = fn
    end    
end

function chemist_com_drinkable:Test(doer)
    if self.test_fn then
        return self.test_fn(self.inst,doer)
    end
    return false
end

function chemist_com_drinkable:SetLayer(layer)
    self.layer = layer
end
function chemist_com_drinkable:SetBuild(build)
    self.build = build
end


return chemist_com_drinkable






