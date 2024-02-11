---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 统一注册 【 images\inventoryimages 】 里的所有图标
--- 每个 xml 里面 只有一个 tex

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

if Assets == nil then
    Assets = {}
end

local files_name = {

	---------------------------------------------------------------------------------------
	-- 02_items
		"chemist_item_firenettles_medicine_bottle",										--- 火荨麻 药剂瓶	
		"chemist_item_empty_bottle",										--- 空瓶
		"chemist_item_herbal_bag",											--- 药材袋
		"chemist_item_pill_box",											--- 药剂匣
		"chemist_item_restorative_medicine_bottle",							--- 通用恢复药剂
		"chemist_item_cola_soda",											--- 可乐
		"chemist_item_plant_growth_medicine",								--- 植物生长药剂
		"chemist_item_wisdom_medicine",										--- 智慧药剂
		"chemist_item_jinkela_medicine",									--- 金坷垃药剂
		"chemist_item_exp_medicine",										--- 经验药剂
	---------------------------------------------------------------------------------------
	-- 03_equipments
		"chemist_equipment_chemical_launching_gun",											--- 药剂发射器
		"chemist_equipment_sublime_backpack",												--- 次元背包

	---------------------------------------------------------------------------------------
	-- 07_foods
		"chemist_food_wisdom_apple",														--- 智慧苹果
	---------------------------------------------------------------------------------------

}

for k, name in pairs(files_name) do
    table.insert(Assets, Asset( "IMAGE", "images/inventoryimages/".. name ..".tex" ))
    table.insert(Assets, Asset( "ATLAS", "images/inventoryimages/".. name ..".xml" ))
	RegisterInventoryItemAtlas("images/inventoryimages/".. name ..".xml", name .. ".tex")
end


