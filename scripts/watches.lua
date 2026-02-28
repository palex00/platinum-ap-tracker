-- Standard Handlers
Archipelago:AddClearHandler("clear handler", onClear)
Archipelago:AddItemHandler("item handler", onItem)
Archipelago:AddLocationHandler("location handler", onLocation)
Archipelago:AddSetReplyHandler("notify handler", onNotify)
Archipelago:AddRetrievedHandler("notify launch handler", onNotifyLaunch)
Archipelago:AddBouncedHandler("map handler", onMap)

-- Toggle Watches
ScriptHost:AddWatchForCode("opt_hmreader", "opt_hmreader", toggle_itemgrid)
ScriptHost:AddWatchForCode("opt_marsh_pass", "opt_marsh_pass", toggle_itemgrid)
ScriptHost:AddWatchForCode("opt_storage_key", "opt_storage_key", toggle_itemgrid)
ScriptHost:AddWatchForCode("opt_unown", "opt_unown", toggle_itemgrid)
ScriptHost:AddWatchForCode("splitmap", "splitmap", toggle_splitmap)
ScriptHost:AddWatchForCode("opt_pastoria_barriers", "opt_pastoria_barriers", toggle_pastoriabarriers)

-- Debug
--ScriptHost:AddWatchForCode("debug", "*", debug)
--ScriptHost:AddOnLocationSectionChangedHandler("debug", debug)