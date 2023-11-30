using Gtk;
using GtkLayerShell;
using GLib;

using Lua;

int box(LuaVM L) {
    var gtkBox = new Box(Gtk.Orientation.VERTICAL, 0);

    return 1;
}

void main(string[] args) {
    Gtk.init(ref args);

    var L = new LuaVM();

    L.open_libs();
    L.register("window", window);
    L.register("box", box);
    L.do_file("./config.lua");

    Gtk.main();
}
