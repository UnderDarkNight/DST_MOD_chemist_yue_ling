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



function chemist_com_drinkable:SetOnDrinkFn(fn)
    if type(fn) == "function" then
        self.on_drink_fn = fn
    end    
end

function chemist_com_drinkable:OnDrink(doer)
    if self.on_drink_fn then
        return self.on_drink_fn(self.inst,doer)
    end
    return false
end


return chemist_com_drinkable






