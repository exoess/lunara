using Gtk;
using GtkLayerShell;
using Lua;

void setAnchors(LuaVM L, Window window) {
    L.get_field(1, "anchor");

    string[] anchor = new string[4];

    foreach (var i in anchor) {
        switch (i) {
            case "top":
                GtkLayerShell.set_anchor(window, GtkLayerShell.Edge.TOP, true);
                break;
            case "right":
                GtkLayerShell.set_anchor(window, GtkLayerShell.Edge.RIGHT, true);
                break;
            case "bottom":
                GtkLayerShell.set_anchor(window, GtkLayerShell.Edge.BOTTOM, true);
                break;
            case "left":
                GtkLayerShell.set_anchor(window, GtkLayerShell.Edge.LEFT, true);
                break;
            default:
                break;
        }
    }

    L.pop(1);
}

void setMargins(LuaVM L, Window window) {
    L.get_field(1, "margins");

    int[] margins = new int[4];
    for (int i = 0; i < 4; i++) {
        L.raw_geti(-1, i + 1);
        margins[i] = L.to_integer(-1);
        L.pop(1);
    }

    L.pop(1);

    GtkLayerShell.set_margin(window, GtkLayerShell.Edge.TOP, margins[0]);
    GtkLayerShell.set_margin(window, GtkLayerShell.Edge.RIGHT, margins[1]);
    GtkLayerShell.set_margin(window, GtkLayerShell.Edge.BOTTOM, margins[2]);
    GtkLayerShell.set_margin(window, GtkLayerShell.Edge.LEFT, margins[3]);
}

public int window(LuaVM L) {
    var gtkWindow = new Window();

    GtkLayerShell.init_for_window(gtkWindow);
    GtkLayerShell.auto_exclusive_zone_enable(gtkWindow);

    setAnchors(L, gtkWindow);
    setMargins(L, gtkWindow);

    gtkWindow.destroy.connect(Gtk.main_quit);
    gtkWindow.show_all();

    return 1;
}
