set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules ${CMAKE_MODULE_PATH})

find_package(KDE4 REQUIRED)

include(KDE4Defaults)

install(FILES colors metadata.desktop DESTINATION ${DATA_INSTALL_DIR}/desktoptheme/VioletPastel/)

FILE(GLOB widgets widgets/*.svgz)
install( FILES ${widgets} DESTINATION ${DATA_INSTALL_DIR}/desktoptheme/VioletPastel/widgets/ )

FILE(GLOB dialogs dialogs/*.svgz)
install( FILES ${dialogs} DESTINATION ${DATA_INSTALL_DIR}/desktoptheme/VioletPastel/dialogs/ )

FILE(GLOB icons icons/*.svgz)
install( FILES ${icons} DESTINATION ${DATA_INSTALL_DIR}/desktoptheme/VioletPastel/icons/ )

FILE(GLOB lancelot lacelot/*.svgz)
install( FILES ${lancelot} DESTINATION ${DATA_INSTALL_DIR}/desktoptheme/VioletPastel/lancelot/ )

FILE(GLOB rssnow rssnow/*.svgz)
install( FILES ${rssnow} DESTINATION ${DATA_INSTALL_DIR}/desktoptheme/VioletPastel/rssnow/ )

FILE(GLOB translucent translucent/dialogs/*.svgz)
install( FILES ${translucent} DESTINATION ${DATA_INSTALL_DIR}/desktoptheme/VioletPastel/translucent/dialogs/ )

FILE(GLOB translucent translucent/widgets/*.svgz)
install( FILES ${translucent} DESTINATION ${DATA_INSTALL_DIR}/desktoptheme/VioletPastel/translucent/widgets/ )