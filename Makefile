VALAC=valac
VALAFLAGS=--pkg gtk+-3.0 --pkg gtk-layer-shell-0 --pkg lua

OUT=main

all: $(OUT)

$(OUT): main.vala ./widgets/window.vala
	$(VALAC) $(VALAFLAGS) $^ -o $@

clean:
	rm -f $(OUT)

