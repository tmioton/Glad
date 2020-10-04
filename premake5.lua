project "Glad"
    kind "StaticLib"
    language "C"

    targetdir(builddir)
    objdir(intermediatesdir)

    files {
        "include/glad/glad.h",
        "include/KHR/khrplatform.h",
        "src/glad.c"
    }

    includedirs {
        "include"
    }

    filter "system:linux"
        systemversion "latest"
        staticruntime "On"

    filter "system:windows"
        systemversion "latest"
        staticruntime "On"

    filter "configurations:Debug"
        runtime "Debug"
        symbols "On"

    filter "configurations:Release"
        runtime "Release"
        optimize "On"
