; MWO Macro by ghost1e - v0.9

#SingleInstance force
#Persistent

isMacro := 0
2xMacro := 1
staggerMacro := 0
varMacro := 0
varcount := 0
vardelay := 480

; Configure the UI
Gui, -SysMenu

Gui, Add, Radio, vMyRadioGroup VisMacro GsaveState, Left/Right Macro
Gui, Add, Radio, V2xMacro GsaveState Checked1, 2x Chainfire Macro
Gui, Add, Radio, VstaggerMacro GsaveState, Stagger Macro
Gui, Add, Radio, VvarMacro GsaveState, Variable Chainfire Macro

Gui, Add, Text, , Chainfire Count: 
Gui, Add, Edit, Vvarcount ReadOnly w80
Gui, Add, UpDown, vMyUpDown GsaveState Range1-10, 1

Gui, Add, Button, w80 GexitMacro, Quit


Gui, Show, , MWO Macro

return

exitMacro:
ExitApp 
return

saveState:
Gui, Submit , NoHide
vardelay := 480 - (varcount * 10)
return

#IfWinActive MechWarrior Online
~*RButton::
if isMacro = 1
{ ; IS ERLL Macro (R->L)
    Sleep , 480
    if GetKeyState("RButton", "P")
    {
        Send , {LButton down}
        Sleep , 500
        Send , {LButton up}
    }
}
else if 2xMacro = 1
{ ; C-ERLL Macro (5 & 6 chainfire)
    loop 
    {
        Send , {5 down}
        Sleep , 5
        Send , {6 down}
        Sleep , 30
        Send , {5 up}
        Send , {6 up}
        Sleep , 445
        
    } until !GetKeyState("RButton", "P")
}
else if staggerMacro = 1
{ ; Stagger Macro (5->6)
    Send , {5 down}
    Sleep , 30
    Send , {5 up}
    Sleep , 450
    if GetKeyState("RButton", "P")
    {
        Send , {6 down}
        Sleep , 30
        Send , {6 up}
    }
}
else if varMacro = 1
{ ; Variable Chain Macro (VARx5 chainfire)
    loop 
    {
        loop, %varcount%
        {
            Send , {5 down}
            Sleep , 5
            Send , {5 up}
            Sleep , 5
        }
        Sleep , %vardelay%
    } until !GetKeyState("RButton", "P")
}
return

~*LButton::
if isMacro = 1
    { ; IS ERLL Macro (L->R)
        Sleep , 480
        if GetKeyState("LButton", "P")
        {
            Send , {RButton down}
            Sleep , 500
            Send , {RButton up}
        }
    }
return