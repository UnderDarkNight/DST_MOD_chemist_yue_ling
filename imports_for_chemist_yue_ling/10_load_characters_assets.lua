------------------------------------------------------------------------------------------------------------------------------------------------------
---- 角色相关的 素材文件
------------------------------------------------------------------------------------------------------------------------------------------------------

if Assets == nil then
    Assets = {}
end

local temp_assets = {


	---------------------------------------------------------------------------
        Asset( "IMAGE", "images/saveslot_portraits/chemist_yue_ling.tex" ), --存档图片
        Asset( "ATLAS", "images/saveslot_portraits/chemist_yue_ling.xml" ),

        Asset( "IMAGE", "bigportraits/chemist_yue_ling.tex" ), --人物大图（方形的那个）
        Asset( "ATLAS", "bigportraits/chemist_yue_ling.xml" ),

        Asset( "IMAGE", "bigportraits/chemist_yue_ling_none.tex" ),  --人物大图（椭圆的那个）
        Asset( "ATLAS", "bigportraits/chemist_yue_ling_none.xml" ),
        
        Asset( "IMAGE", "images/map_icons/chemist_yue_ling.tex" ), --小地图
        Asset( "ATLAS", "images/map_icons/chemist_yue_ling.xml" ),
        
        Asset( "IMAGE", "images/avatars/avatar_chemist_yue_ling.tex" ), --tab键人物列表显示的头像  --- 直接用小地图那张就行了
        Asset( "ATLAS", "images/avatars/avatar_chemist_yue_ling.xml" ),
        
        Asset( "IMAGE", "images/avatars/avatar_ghost_chemist_yue_ling.tex" ),--tab键人物列表显示的头像（死亡）
        Asset( "ATLAS", "images/avatars/avatar_ghost_chemist_yue_ling.xml" ),
        
        Asset( "IMAGE", "images/avatars/self_inspect_chemist_yue_ling.tex" ), --人物检查按钮的图片
        Asset( "ATLAS", "images/avatars/self_inspect_chemist_yue_ling.xml" ),
        
        Asset( "IMAGE", "images/names_chemist_yue_ling.tex" ),  --人物名字
        Asset( "ATLAS", "images/names_chemist_yue_ling.xml" ),
        
        Asset("ANIM", "anim/chemist_yue_ling.zip"),              --- 人物动画文件
        Asset("ANIM", "anim/ghost_chemist_yue_ling_build.zip"),  --- 灵魂状态动画文件



	---------------------------------------------------------------------------


}
-- for i = 1, 30, 1 do
--     print("fake error ++++++++++++++++++++++++++++++++++++++++")
-- end
for k, v in pairs(temp_assets) do
    table.insert(Assets,v)
end

