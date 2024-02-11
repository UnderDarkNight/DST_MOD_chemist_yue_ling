----------------------------------------------------------------------------------------------------------------------------------
--[[

     等级系统
     
     ​可以升级，满级200级，每升一级三维增加1点（需要经验药剂）
     （升级方案，1-10级每级需要一个经验药剂，11-20每级需要两个经验药剂。。。以此类推）

     1瓶药水 1EXP
     
    1 -  10 :  1 EXP
    11 - 20 : 2 EXP
    21 - 30 : 3 EXP
    ...
    191 - 200 : 20 EXP
     （更换角色等级保留）

]]--
----------------------------------------------------------------------------------------------------------------------------------
local chemist_com_level_sys = Class(function(self, inst)
    self.inst = inst

    self.current_level = 0
    self.max_level = 200

    self.current_exp = 0

end,
nil,
{

})



----------------------------------------------------------------------------------------------------------------------------------
--- 等级的增加

    function chemist_com_level_sys:LevelUp(num)
        num = num or 1
        self.current_level = self.current_level + num
        if self.current_level > self.max_level then
            self.current_level = self.max_level
        end

        if self._on_level_changed_fn then
            self._on_level_changed_fn(self.current_level)
        end

    end
    
    function chemist_com_level_sys:Get_Level()
        return self.current_level
    end

    function chemist_com_level_sys:IsMaxLevel()
        return self.current_level >= self.max_level
    end

    function chemist_com_level_sys:Add_Level_Changed_Fn(fn)
        if type(fn) == "function" then
            self._on_level_changed_fn = fn
        end
    end


----------------------------------------------------------------------------------------------------------------------------------
--- 经验值
    --[[
             （升级方案，1-10级每级需要一个经验药剂，11-20每级需要两个经验药剂。。。以此类推）
                1瓶药水 1EXP                
                1 -  10 :  1 EXP
                11 - 20 : 2 EXP
                21 - 30 : 3 EXP
                ...
                191 - 200 : 20 EXP
    ]]--
    function chemist_com_level_sys:Add_Exp(exp)
        exp = exp or 1
        self.current_exp = self.current_exp + exp
        local next_level_exp = self:Get_Next_Level_Exp()
        if next_level_exp == 0 then
            return
        end

        if self.current_exp >= next_level_exp then
            self:LevelUp(1)
            self.current_exp = self.current_exp - next_level_exp
            self:Add_Exp(0)
        else
            return
        end
    end
    function chemist_com_level_sys:Get_Next_Level_Exp()
        local current_level = self:Get_Level()
        if current_level >= self.max_level then
            return 0
        end
        return math.floor(current_level/10) + 1
    end
----------------------------------------------------------------------------------------------------------------------------------
--- 添加 onload fn
    function chemist_com_level_sys:SetOnLoadFn(fn)
        if type(fn) == "function" then
            self._on_load_fn = fn
        end
    end
----------------------------------------------------------------------------------------------------------------------------------
--- 储存/读取
    function chemist_com_level_sys:OnSave()
        local data =
        {
            current_level = self.current_level,
            current_exp = self.current_exp,
        }

        return next(data) ~= nil and data or nil
    end

    function chemist_com_level_sys:OnLoad(data)

        if data.current_level then
            self.current_level = data.current_level
        end
        if data.current_exp then
            self.current_exp = data.current_exp
        end


        if self._on_load_fn then
            self._on_load_fn()
        end
    end
----------------------------------------------------------------------------------------------------------------------------------

return chemist_com_level_sys






