----------------------------------------------------------------------------------------------------------------------------------
--[[

     通用数据储存库，用来储存各种 【文本】数据

]]--
----------------------------------------------------------------------------------------------------------------------------------
local chemist_com_database = Class(function(self, inst)
    self.inst = inst

    self.DataTable = {}
    self.TempTable = {}
    self._onload_fns = {}
end,
nil,
{

})
---------------------------------------------------------------------------------------------------
----- onload 函数
    function chemist_com_database:AddOnLoadFn(fn)
        if type(fn) == "function" then
            table.insert(self._onload_fns, fn)
        end
    end
    function chemist_com_database:ActiveOnLoadFns()
        for k, temp_fn in pairs(self._onload_fns) do
            temp_fn(self)
        end
    end
---------------------------------------------------------------------------------------------------
----- 数据读取/储存
    function chemist_com_database:SaveData(DataName_Str,theData)
        if DataName_Str then
            self.DataTable[DataName_Str] = theData
        end
    end

    function chemist_com_database:ReadData(DataName_Str)
        if DataName_Str then
            if self.DataTable[DataName_Str] then
                return self.DataTable[DataName_Str]
            else
                return nil
            end
        end
    end
    function chemist_com_database:Get(DataName_Str)
        return self:ReadData(DataName_Str)
    end
    function chemist_com_database:Set(DataName_Str,theData)
        self:SaveData(DataName_Str, theData)
    end

    function chemist_com_database:Add(DataName_Str,num)
        if self:Get(DataName_Str) == nil then
            self:Set(DataName_Str, 0)
        end
        if type(num) ~= "number" or type(self:Get(DataName_Str))~="number" then
            return
        end
        self:Set(DataName_Str, self:Get(DataName_Str) + num)
        return self:Get(DataName_Str)
    end
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------
    function chemist_com_database:OnSave()
        local data =
        {
            DataTable = self.DataTable
        }

        return next(data) ~= nil and data or nil
    end

    function chemist_com_database:OnLoad(data)
        if data.DataTable then
            self.DataTable = data.DataTable
        end
        self:ActiveOnLoadFns()
    end
------------------------------------------------------------------------------------------------------------------------------
return chemist_com_database







