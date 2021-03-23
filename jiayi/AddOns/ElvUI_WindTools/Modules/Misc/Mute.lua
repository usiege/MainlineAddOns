local W, F, E, L = unpack(select(2, ...))
local M = W:GetModule("Misc")

local pairs = pairs
local MuteSoundFile = MuteSoundFile
local UnmuteSoundFile = UnmuteSoundFile

local MountSE = {
    [63796] = {
        -- 彌米倫之首
        568252, -- spells/summongyrocopter.ogg
        595100, -- creature/mimironheadmount/mimironheadmount_walk.ogg
        555364, -- creature/mimironheadmount/mimironheadmount_run.ogg
        595103, -- creature/mimironheadmount/mimironheadmount_jumpstart.ogg
        595097 -- creature/mimironheadmount/mimironheadmount_jumpend.ogg
    },
    [229385] = {
        -- 班盧，宗師良伴
        1593212, -- creature/ban-lu/vo_72_ban-lu_01_m.ogg
        1593213, -- creature/ban-lu/vo_72_ban-lu_02_m.ogg
        1593214, -- creature/ban-lu/vo_72_ban-lu_03_m.ogg
        1593215, -- creature/ban-lu/vo_72_ban-lu_04_m.ogg
        1593216, -- creature/ban-lu/vo_72_ban-lu_05_m.ogg
        1593217, -- creature/ban-lu/vo_72_ban-lu_06_m.ogg
        1593218, -- creature/ban-lu/vo_72_ban-lu_07_m.ogg
        1593219, -- creature/ban-lu/vo_72_ban-lu_08_m.ogg
        1593220, -- creature/ban-lu/vo_72_ban-lu_09_m.ogg
        1593221, -- creature/ban-lu/vo_72_ban-lu_10_m.ogg
        1593222, -- creature/ban-lu/vo_72_ban-lu_11_m.ogg
        1593223, -- creature/ban-lu/vo_72_ban-lu_12_m.ogg
        1593224, -- creature/ban-lu/vo_72_ban-lu_13_m.ogg
        1593225, -- creature/ban-lu/vo_72_ban-lu_14_m.ogg
        1593226, -- creature/ban-lu/vo_72_ban-lu_15_m.ogg
        1593227, -- creature/ban-lu/vo_72_ban-lu_16_m.ogg
        1593228, -- creature/ban-lu/vo_72_ban-lu_17_m.ogg
        1593229, -- creature/ban-lu/vo_72_ban-lu_18_m.ogg
        1593230, -- creature/ban-lu/vo_72_ban-lu_19_m.ogg
        1593231, -- creature/ban-lu/vo_72_ban-lu_20_m.ogg
        1593232, -- creature/ban-lu/vo_72_ban-lu_21_m.ogg
        1593233, -- creature/ban-lu/vo_72_ban-lu_22_m.ogg
        1593234, -- creature/ban-lu/vo_72_ban-lu_23_m.ogg
        1593235, -- creature/ban-lu/vo_72_ban-lu_24_m.ogg
        1593236 -- creature/ban-lu/vo_72_ban-lu_25_m.ogg
    },
    [339588] = {
        -- 罪奔者布蘭契
        3587276 -- Part of SoundKit(s): 157142, 160875, 166787, 167500, 167947, 172866
    },
    [312762] = {
        -- 淵誓獵魂犬
        3745490, --sound/creature/talethi's_target/mon_talethi's_target_fidget01_01_168902.ogg
        3745492, --sound/creature/talethi's_target/mon_talethi's_target_fidget01_02_168902.ogg
        3745494, --sound/creature/talethi's_target/mon_talethi's_target_fidget01_03_168902.ogg
        3745496, --sound/creature/talethi's_target/mon_talethi's_target_fidget01_04_168902.ogg
        3745498, --sound/creature/talethi's_target/mon_talethi's_target_fidget01_05_168902.ogg
        3745500, --sound/creature/talethi's_target/mon_talethi's_target_fidget01_06_168902.ogg
        3745502, --sound/creature/talethi's_target/mon_talethi's_target_fidget01_07_168902.ogg
        3745504, --sound/creature/talethi's_target/mon_talethi's_target_fidget01_08_168902.ogg
        3745506, --sound/creature/talethi's_target/mon_talethi's_target_fidget01_09_168902.ogg
        3745508, --sound/creature/talethi's_target/mon_talethi's_target_fidget01_10_168902.ogg
        3745510, --sound/creature/talethi's_target/mon_talethi's_target_fidget01_11_168902.ogg
        3745512, --sound/creature/talethi's_target/mon_talethi's_target_fidget01_12_168902.ogg
        3745514, --sound/creature/talethi's_target/mon_talethi's_target_fidget01_13_168902.ogg
        3745516, --sound/creature/talethi's_target/mon_talethi's_target_fidget01_14_168902.ogg
        3745518, --sound/creature/talethi's_target/mon_talethi's_target_fidget01_15_168902.ogg
        3745520, --sound/creature/talethi's_target/mon_talethi's_target_fidget01_16_168902.ogg
        3745566 --sound/creature/talethi's_target/mon_talethi's_target_fidget02_01_168903.ogg
    }
}

local OtherSE = {
    ["Tortollan"] = {
        -- 托爾托人
        1979406, -- sound/creature/tortollan_female/vo_801_tortollan_female_01_f.ogg
        1979407, -- sound/creature/tortollan_female/vo_801_tortollan_female_02_f.ogg
        1979408, -- sound/creature/tortollan_female/vo_801_tortollan_female_03_f.ogg
        1979409, -- sound/creature/tortollan_female/vo_801_tortollan_female_04_f.ogg
        1979410, -- sound/creature/tortollan_female/vo_801_tortollan_female_05_f.ogg
        1979411, -- sound/creature/tortollan_female/vo_801_tortollan_female_06_f.ogg
        1979412, -- sound/creature/tortollan_female/vo_801_tortollan_female_07_f.ogg
        1979413, -- sound/creature/tortollan_female/vo_801_tortollan_female_08_f.ogg
        1979414, -- sound/creature/tortollan_female/vo_801_tortollan_female_09_f.ogg
        1979415, -- sound/creature/tortollan_female/vo_801_tortollan_female_10_f.ogg
        1979416, -- sound/creature/tortollan_female/vo_801_tortollan_female_11_f.ogg
        1979439, -- sound/creature/tortollan_male_child/vo_801_tortollan_male_child_01_m.ogg
        1979440, -- sound/creature/tortollan_male_child/vo_801_tortollan_male_child_02_m.ogg
        1979441, -- sound/creature/tortollan_male_child/vo_801_tortollan_male_child_03_m.ogg
        1979442, -- sound/creature/tortollan_male_child/vo_801_tortollan_male_child_04_m.ogg
        1979443, -- sound/creature/tortollan_male_child/vo_801_tortollan_male_child_05_m.ogg
        1979444, -- sound/creature/tortollan_male_child/vo_801_tortollan_male_child_06_m.ogg
        1979445, -- sound/creature/tortollan_male_child/vo_801_tortollan_male_child_07_m.ogg
        1979446, -- sound/creature/tortollan_male_child/vo_801_tortollan_male_child_08_m.ogg
        1979447, -- sound/creature/tortollan_male_child/vo_801_tortollan_male_child_09_m.ogg
        1998109, -- sound/creature/tortollan_male/vo_801_tortollan_male_01_m.ogg
        1998110, -- sound/creature/tortollan_male/vo_801_tortollan_male_02_m.ogg
        1998111, -- sound/creature/tortollan_male/vo_801_tortollan_male_03_m.ogg
        1998112, -- sound/creature/tortollan_male/vo_801_tortollan_male_04_m.ogg
        1998113, -- sound/creature/tortollan_male/vo_801_tortollan_male_05_m.ogg
        1998114, -- sound/creature/tortollan_male/vo_801_tortollan_male_06_m.ogg
        1998115, -- sound/creature/tortollan_male/vo_801_tortollan_male_07_m.ogg
        1998116, -- sound/creature/tortollan_male/vo_801_tortollan_male_08_m.ogg
        1998117, -- sound/creature/tortollan_male/vo_801_tortollan_male_09_m.ogg
        1998118, -- sound/creature/tortollan_male/vo_801_tortollan_male_10_m.ogg
        1998119, -- sound/creature/tortollan_male/vo_801_tortollan_male_11_m.ogg
        1998120, -- sound/creature/tortollan_male/vo_801_tortollan_male_12_m.ogg
        1998121, -- sound/creature/tortollan_male/vo_801_tortollan_male_13_m.ogg
        1998122 -- sound/creature/tortollan_male/vo_801_tortollan_male_14_m.ogg
    }
}

function M:Mute()
    for mountID, soundIDs in pairs(MountSE) do
        if E.private.WT.misc.mute.enable and E.private.WT.misc.mute.mount[mountID] then
            for _, soundID in pairs(soundIDs) do
                MuteSoundFile(soundID)
            end
        else
            for _, soundID in pairs(soundIDs) do
                UnmuteSoundFile(soundID)
            end
        end
    end

    for cat, soundIDs in pairs(OtherSE) do
        if E.private.WT.misc.mute.enable and E.private.WT.misc.mute.other[cat] then
            for _, soundID in pairs(soundIDs) do
                MuteSoundFile(soundID)
            end
        else
            for _, soundID in pairs(soundIDs) do
                UnmuteSoundFile(soundID)
            end
        end
    end
end

M:AddCallback("Mute")
