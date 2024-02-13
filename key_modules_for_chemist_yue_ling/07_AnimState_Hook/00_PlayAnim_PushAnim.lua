-- if TUNING["chemist_yue_ling.AnimStateFn"] == nil then
--     TUNING["chemist_yue_ling.AnimStateFn"] = {}
-- end

-- -- TUNING["chemist_yue_ling.AnimStateFn"]["00_PlayAnim_PushAnim"] = function(theAnimState)

-- --     ------ 
-- --     if theAnimState.PlayAnimation_old_chemist_yue_ling == nil then  --- 避免重复hook        
-- --         ----------------------------------------------------------------------------------
-- --         theAnimState.PlayAnimation_old_chemist_yue_ling = theAnimState.PlayAnimation
-- --         theAnimState.PlayAnimation = function(self,anim_name,...)         
-- --             if self.inst and self.inst:HasTag("player") then   
-- --                 print("PlayAnimation",self.inst,anim_name)
-- --             end
-- --             self:PlayAnimation_old_chemist_yue_ling(anim_name,...)
-- --         end
-- --         ----------------------------------------------------------------------------------
-- --         theAnimState.PushAnimation_old_chemist_yue_ling = theAnimState.PushAnimation
-- --         theAnimState.PushAnimation = function(self,anim_name,...)
-- --             if self.inst and self.inst:HasTag("player") then   
-- --                 print("PushAnimation",self.inst,anim_name)
-- --             end
-- --             self:PushAnimation_old_chemist_yue_ling(anim_name,...)
-- --         end
-- --         ----------------------------------------------------------------------------------
-- --     end

-- -- end