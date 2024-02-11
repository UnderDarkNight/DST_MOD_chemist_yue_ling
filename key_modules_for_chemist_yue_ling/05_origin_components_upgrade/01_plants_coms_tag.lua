




local plant_coms = {
    "farmplantstress",
    "witherable",
    "growable",
    "pickable",
    "crop",
    "harvestable",
}



for k, the_com in pairs(plant_coms) do
        AddComponentPostInit(the_com, function(self)


                self.inst:AddTag("chemist_tag.plants")


                -- if not TheWorld.ismastersim then
                --         return
                -- end
                

                -- if self.inst.components.chemist_com_database == nil then
                --         self.inst:AddComponent("chemist_com_database")
                -- end

                -- -- inst.components.pickable:IsBarren()  --- 枯萎判定


        end)
end
