include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

if("public-preview" IN_LIST FEATURES)
    vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO Azure/azure-umqtt-c
        REF 1b3a25f4f7f0edbe068e261e8a808d7bc394a358
        SHA512 00ff90eccfbb4febded7e819baa6303e97d3e7d6f6f8f1a28ebf353d7ad7ac5ec7f479e66456f395c7ece7fd6d612f3948ac656420bc0bc75566bdbb65fb88c3
        HEAD_REF public-preview
    )
else()
    vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO Azure/azure-umqtt-c
        REF 3205eb26401e9c6639100934e8fb75b75275760d
        SHA512 002c0d4f0373faeb7171465afce268f18b52d80ec057af36c81dd807de8ccf2bf1a46ef00c7f8e8fcdbef8d7f5c36616a304007c98ea5700c5f662b4c8868c2c
        HEAD_REF master
    )
endif()

file(COPY ${CURRENT_INSTALLED_DIR}/share/azure-c-shared-utility/azure_iot_build_rules.cmake DESTINATION ${SOURCE_PATH}/deps/c-utility/configs/)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -Dskip_samples=ON
        -Duse_installed_dependencies=ON
        -Dbuild_as_dynamic=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH cmake TARGET_PATH share/umqtt)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include ${CURRENT_PACKAGES_DIR}/debug/share)

configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/azure-umqtt-c/copyright COPYONLY)

vcpkg_copy_pdbs()
