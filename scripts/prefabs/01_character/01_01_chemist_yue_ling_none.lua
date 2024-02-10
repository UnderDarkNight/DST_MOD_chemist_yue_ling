local assets =
{
	Asset( "ANIM", "anim/chemist_yue_ling.zip" ),
	Asset( "ANIM", "anim/ghost_chemist_yue_ling_build.zip" ),
}
local skin_fns = {

	-----------------------------------------------------
		CreatePrefabSkin("chemist_yue_ling_none",{
			base_prefab = "chemist_yue_ling",			---- 角色prefab
			skins = {
					normal_skin = "chemist_yue_ling",					--- 正常外观
					ghost_skin = "ghost_chemist_yue_ling_build",			--- 幽灵外观
			}, 								
			assets = assets,
			skin_tags = {"BASE" ,"CHEMIST_YUE_LING", "CHARACTER"},		--- 皮肤对应的tag
			
			build_name_override = "chemist_yue_ling",
			rarity = "Character",
		}),
	-----------------------------------------------------
	-----------------------------------------------------
		-- CreatePrefabSkin("chemist_yue_ling_skin_flame",{
		-- 	base_prefab = "chemist_yue_ling",			---- 角色prefab
		-- 	skins = {
		-- 			normal_skin = "chemist_yue_ling_skin_flame", 		--- 正常外观
		-- 			ghost_skin = "ghost_chemist_yue_ling_build",			--- 幽灵外观
		-- 	}, 								
		-- 	assets = assets,
		-- 	skin_tags = {"BASE" ,"chemist_yue_ling_CARL", "CHARACTER"},		--- 皮肤对应的tag
			
		-- 	build_name_override = "chemist_yue_ling",
		-- 	rarity = "Character",
		-- }),
	-----------------------------------------------------

}

return unpack(skin_fns)