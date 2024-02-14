--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    技能点系统

    按键事件走RPC Event

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local chemist_com_skill_point_sys = Class(function(self, inst)
    self.inst = inst

    self.DataTable = {}
    self.TempTable = {}

    self.free_points = 0    --- 空余点数
    self.all_points = 0

    self.button_click_fns = {}

    self.inst:ListenForEvent("chemist_com_skill_point_sys.ButtonClick",function(_,index)
        self:ButtonClick(index)
    end)

    inst:DoTaskInTime(0,function()
        self:Data_Synchronization() --- 同步去client
    end)
    
end,
nil,
{

})

----------------------------------------------------------------------------------------------------------------------------------
---- free points
    function chemist_com_skill_point_sys:FreePointDelta(num)
        if type(num) ~= "number" then
            return
        end
        self.free_points = self.free_points + num

        if self.free_points < 0 then
            self.free_points = 0
        end

        if num > 0 then
            self.all_points = self.all_points + num
        end
        self:Data_Synchronization()
    end
    function chemist_com_skill_point_sys:GetFreePoints()
        return self.free_points or 0
    end

    function chemist_com_skill_point_sys:ResetAllPoints() --- 重置技能书所有点数
        self.free_points = self.all_points
        self.DataTable = {}
        self:Data_Synchronization()
    end
----------------------------------------------------------------------------------------------------------------------------------
---- 按键事件
    function chemist_com_skill_point_sys:ButtonClick(index)
        if type(index) == "string" and self.button_click_fns[index] then
            for k, fn in pairs(self.button_click_fns[index]) do
                fn()
            end
        end
        self:Data_Synchronization()
    end
    function chemist_com_skill_point_sys:AddButtonFn(index,fn)
        if type(index) == "string" and type(fn) == "function" then
            self.button_click_fns[index] = self.button_click_fns[index] or {}
            table.insert(self.button_click_fns[index],fn)
        end
    end
----------------------------------------------------------------------------------------------------------------------------------
---- 数据同步
    function chemist_com_skill_point_sys:Data_Synchronization()
        local datas = {
            free_points = self.free_points,
            DataTable = self.DataTable,
        }
        self.inst.components.chemist_com_rpc_event:PushEvent("chemist_com_skill_point_sys.Data_Synchronization",datas)
    end
----------------------------------------------------------------------------------------------------------------------------------
--- 数据储存
        function chemist_com_skill_point_sys:SaveData(DataName_Str,theData)
            if DataName_Str then
                self.DataTable[DataName_Str] = theData
            end
        end

        function chemist_com_skill_point_sys:ReadData(DataName_Str)
            if DataName_Str then
                if self.DataTable[DataName_Str] then
                    return self.DataTable[DataName_Str]
                else
                    return nil
                end
            end
        end
        function chemist_com_skill_point_sys:Get(DataName_Str)
            return self:ReadData(DataName_Str)
        end
        function chemist_com_skill_point_sys:Set(DataName_Str,theData)
            self:SaveData(DataName_Str, theData)
        end

        function chemist_com_skill_point_sys:Add(DataName_Str,num)
            if self:Get(DataName_Str) == nil then
                self:Set(DataName_Str, 0)
            end
            if type(num) ~= "number" or type(self:Get(DataName_Str))~="number" then
                return
            end
            self:Set(DataName_Str, self:Get(DataName_Str) + num)
            return self:Get(DataName_Str)
        end

        function chemist_com_skill_point_sys:OnSave()
            local data =
            {
                DataTable = self.DataTable,
                free_points = self.free_points,
                all_points = self.all_points,
            }

            return next(data) ~= nil and data or nil
        end

        function chemist_com_skill_point_sys:OnLoad(data)
            if data.DataTable then
                self.DataTable = data.DataTable
            end
            if data.free_points then
                self.free_points = data.free_points
            end
            if data.all_points then
                self.all_points = data.all_points
            end

            -- self.inst:DoTaskInTime(0,function()
            -- end)
        end
----------------------------------------------------------------------------------------------------------------------------------
return chemist_com_skill_point_sys