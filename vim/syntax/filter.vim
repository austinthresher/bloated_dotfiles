" vim syntax highlighting for Path of Exile item filters files (.filter)
if exists("b:current_syntax")
    finish
endif

let b:current_syntax = "filter"

syn keyword poeInfluence contained
    \ Crusader Elder Hunter Redeemer Shaper Warlord None
syn keyword poeIconShape contained
    \ Circle Diamond Hexagon Square Star
    \ Triangle Cross Moon Raindrop Kite Pentagon UpsideDownHouse
syn keyword poeIconColor contained
    \ Red Green Blue Brown White Yellow Cyan Grey Orange Pink Purple

syn match poeComment "\v#.*$"
syn region poeString contained oneline
    \ start=/\v"/
    \ skip=/\v\\./
    \ end=/\v"/

syn match poeNumber contained '\d'

syn match poeOperator contained '>='
syn match poeOperator contained '<='
syn match poeOperator contained '=='
syn match poeOperator contained '<'
syn match poeOperator contained '>'
syn match poeOperator contained '='
syn match poeArgs contained
    \ '[^#]*'
    \ contains=poeString,poeOperator,poeNumber,poeInfluence,poeIconShape,poeIconColor
    \ nextgroup=poeComment


syn keyword poeBlock Show Hide
syn keyword poeCondition
    \ AreaLevel ItemLevel DropLevel Quality Rarity Class BaseType Prophecy
    \ LinkedSockets SocketGroup Sockets Height Width HasExplicitMod
    \ AnyEnchantment HasEnchantment EnchantmentPassiveNode StackSize GemLevel
    \ GemQualityType AlternateQuality Replica Identified Corrupted
    \ CorruptedMods Mirrored ElderItem ShaperItem HasInfluence FracturedItem
    \ SynthesizedItem ShapedMap MapTier
    \ nextgroup=poeArgs

syn keyword poeAction 
    \ SetBorderColor SetTextColor SetBackgroundColor
    \ SetFontSize PlayAlertSound PlayAlertSoundPositional
    \ DisableDropSound CustomAlertSound MinimapIcon PlayEffect 
    \ nextgroup=poeArgs


hi def link poeComment Comment
hi def link poeString Type
hi def link poeInfluence Type
hi def link poeIconShape Type
hi def link poeIconColor Type
hi def link poeNumber Normal
hi def link poeOperator Operator
hi def link poeArgs String
hi def link poeBlock Function
hi def link poeCondition Statement
hi def link poeAction PreProc
