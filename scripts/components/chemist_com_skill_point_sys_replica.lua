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

    self.free_points = 0

    self._update_fns = {}

    self.inst:ListenForEvent("chemist_com_skill_point_sys.Data_Synchronization",function(_,_table)
        if not _table then
            return
        end

        self.DataTable = _table.DataTable
        self.free_points = _table.free_points
        self:DataRefresh()
    end)

end,
nil,
{

})

----------------------------------------------------------------------------------------------------------------------------------
---- 数据刷新调取API
    function chemist_com_skill_point_sys:DataRefresh()
        for k, fn in pairs(self._update_fns) do
            fn()
        end
    end

    function chemist_com_skill_point_sys:AddDataUpdateFn(fn)
        if type(fn) == "function" then
            table.insert(self._update_fns,fn)
        end
    end
    function chemist_com_skill_point_sys:ClearUpdateFns()
        self._update_fns = {}
    end
----------------------------------------------------------------------------------------------------------------------------------
---- 
    function chemist_com_skill_point_sys:Get(index)
        if type(index) == "string" then
            return self.DataTable[index]
        end
        return nil
    end
    function chemist_com_skill_point_sys:GetFreePoints()
        return self.free_points or 0
    end
----------------------------------------------------------------------------------------------------------------------------------
---- 
    function chemist_com_skill_point_sys:ButtonClick(index)
        if type(index) == "string" then
            self.inst.replica.chemist_com_rpc_event:PushEvent("chemist_com_skill_point_sys.ButtonClick",index)
        end
    end
----------------------------------------------------------------------------------------------------------------------------------

return chemist_com_skill_point_sys