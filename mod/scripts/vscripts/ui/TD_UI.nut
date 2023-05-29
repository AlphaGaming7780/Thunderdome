global function TD_UI

void function TD_UI() {
    
    /*
    ModSettings_AddModTitle( "#MOD_TITLE" )

    ModSettings_AddModCategory( "#Dev_settings" )
    ModSettings_AddEnumSetting( "TD_EnableDevMod", "#TD_EnableDevMod", [ "#TD_Disabled", "#TD_Enabled" ] )
    */

#if PLAYER_HAS_MOD_SETTINGS
    AddModTitle( "#MOD_TITLE" )

    AddModCategory( "#TD_Dev_settings" )
    AddConVarSettingEnum( "TD_EnableDevMod", "#TD_EnableDevMod", [ "#SETTING_DISABLED", "#SETTING_ENABLED" ] )
#endif

}