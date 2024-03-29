---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 统一注册 【 images\map_icons 】 里的所有图标
--- 每个 xml 里面 只有一个 tex

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

if Assets == nil then
    Assets = {}
end

local files_name = {
	-------------------------------------------------------------------------------------------------
	---- 00_chemist_yue_ling_others
	---- 22_chemist_yue_ling_npc
	-------------------------------------------------------------------------------------------------
		"chemist_yue_ling",						--- 小地图图标
		"chemist_building_pharmaceutical_manufacturing_station",						--- 药剂制作站
		"chemist_building_mushroom_house",						--- 蘑菇屋
		"chemist_building_moonshine_converter",						--- 月光转换器
		"chemist_plant_wisdom_apple_tree",						--- 智慧树
	-------------------------------------------------------------------------------------------------
	---- 23_chemist_yue_ling_wellness


}

for k, name in pairs(files_name) do
    table.insert(Assets, Asset( "IMAGE", "images/map_icons/".. name ..".tex" ))
    table.insert(Assets, Asset( "ATLAS", "images/map_icons/".. name ..".xml" ))
	AddMinimapAtlas("images/map_icons/".. name ..".xml")
	RegisterInventoryItemAtlas("images/map_icons/".. name ..".xml",name..".tex")	
end


