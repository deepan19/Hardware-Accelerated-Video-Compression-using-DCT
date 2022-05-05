set_global_assignment -entity "RFS_WiFi" -library "lib_RFS_WiFi" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "RFS_WiFi" -library "lib_RFS_WiFi" -name IP_TOOL_VERSION "17.0"
set_global_assignment -entity "RFS_WiFi" -library "lib_RFS_WiFi" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_RFS_WiFi" -name SPD_FILE [file join $::quartus(sip_path) "../RFS_WiFi.spd"]
set_global_assignment -library "lib_RFS_WiFi" -name MISC_FILE [file join $::quartus(sip_path) "../../RFS_WiFi.qsys"]

set_global_assignment -library "lib_RFS_WiFi" -name MISC_FILE [file join $::quartus(sip_path) "RFS_WiFi.v"]
