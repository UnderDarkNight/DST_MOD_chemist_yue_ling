
if Assets == nil then
    Assets = {}
end

local temp_assets = {

    ----- 基础背景按钮
        Asset("IMAGE", "images/widget/chemist_skill_book_base.tex"),
        Asset("ATLAS", "images/widget/chemist_skill_book_base.xml"),

    ----- 攻击力倍增药剂
        Asset("IMAGE", "images/widget/chemist_skill_book_attack_power_multiplier_medicine.tex"),
        Asset("ATLAS", "images/widget/chemist_skill_book_attack_power_multiplier_medicine.xml"),
    ----- 三维恢复药剂
        Asset("IMAGE", "images/widget/chemist_skill_book_triple_recovery_medicine.tex"),
        Asset("ATLAS", "images/widget/chemist_skill_book_triple_recovery_medicine.xml"),




}

for k, v in pairs(temp_assets) do
    table.insert(Assets,v)
end

