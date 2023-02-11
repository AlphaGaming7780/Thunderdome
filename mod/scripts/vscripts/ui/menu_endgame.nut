global function TBR_GetActiveMenu
global function TBR_Init

void function TBR_GetActiveMenu() {
    
    AdvanceMenu( GetMenu( "endgamemenu" ) )
    //AdvanceMenu("ScoreboardPanel")
    
    PrintMenuStack()
    //RunClientScript( "WriteInGameChat", GetActiveMenu() )
    print(GetActiveMenu())
}

void function TBR_Init() { 
    AddMenu("endgamemenu", $"resource/ui/menus/endgame.menu")
    AddPanel(GetMenu( "endgamemenu" ),"ScoreboardPanel")
}
