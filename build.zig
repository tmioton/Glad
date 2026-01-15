const std = @import("std");


pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const include_src = b.option(bool, "include_src", "Add the src/ directory as an include directory") orelse false;

    const lib = b.addLibrary(.{
        .name = "glad",
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize,
            .link_libc = true,
        }),
        .linkage = .static,
    });
    lib.root_module.addIncludePath(b.path("include"));

    lib.installHeadersDirectory(b.path("include/glad"), "glad", .{});
    if (include_src) {
        lib.installHeadersDirectory(b.path("src/"), "glad", .{});
        // To maintain the relative paths inside the files in src/
        lib.installHeadersDirectory(b.path("include/glad"), "include/glad", .{});
    }

    lib.root_module.addCSourceFile(.{.file = b.path("src/gl.c"), .language = .c});
    b.installArtifact(lib);
}
