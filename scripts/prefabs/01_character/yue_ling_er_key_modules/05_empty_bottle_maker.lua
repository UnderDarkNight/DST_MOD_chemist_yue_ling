--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    制作空瓶，有概率 得多几个

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return function(inst)
    if not TheWorld.ismastersim then
        return
    end




    
    inst:ListenForEvent("chemist_empty_bottle_maked",function(_,item)
        if item then
                        
            if inst.components.sanity:IsLunacyMode() then    --- 启蒙状态做瓶子  随机得 1-3
                item.components.stackable.stacksize = math.random(3)
            end
            
        end
    end)

end