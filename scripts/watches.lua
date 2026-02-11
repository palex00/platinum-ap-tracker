-- Standard Handlers
Archipelago:AddClearHandler("clear handler", onClear)
Archipelago:AddItemHandler("item handler", onItem)
Archipelago:AddLocationHandler("location handler", onLocation)
Archipelago:AddSetReplyHandler("notify handler", onNotify)
Archipelago:AddRetrievedHandler("notify launch handler", onNotifyLaunch)

-- Toggle Watches
ScriptHost:AddWatchForCode("opt_ssticket", "opt_ssticket", toggle_itemgrid)
ScriptHost:AddWatchForCode("opt_marsh_pass", "opt_marsh_pass", toggle_itemgrid)
ScriptHost:AddWatchForCode("opt_storage_key", "opt_storage_key", toggle_itemgrid)
ScriptHost:AddWatchForCode("opt_unown", "opt_unown", toggle_itemgrid)

-- Debug
ScriptHost:AddWatchForCode("debug", "*", debug)
ScriptHost:AddOnLocationSectionChangedHandler("debug", debug)