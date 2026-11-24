// Spaces picker: the spaces half of cmd+p on its own. Type to filter spaces by
// name, folder, branch or machine — or by the index shown on the left, where 0
// is the first space. ↑↓ to move; the right column follows the hovered or
// selected space and lists its tabs with agent status and program, like cmd+p.
// Enter switches to the space. Clicking a tab goes straight to it. Opened from
// the tmux prefix (Ctrl+Space, then s) or with
// `herdr-app do mod.open --name spaces-picker`.

import { View, div, svg } from "gpui-kit";
import { v_flex, h_flex, InputState, Input, ScrollHandle } from "gpui-base";
import { agents, spaces, run, theme, props, closeOverlay, shared, setShared } from "herdr";

const MARK = { ansi6: "#22a99a", ansi3: "#e3814f", ansi4: "#5b8def", ansi5: "#8b7cf6", ansi2: "#3fae6a", ansi1: "#d9649a" };

// Space colors, kept by space id in shared "space.colors": the same rule the
// shipped picker and spaces mods use, so a space keeps one color everywhere.
const PROJECT_COLORS = ["ansi6", "ansi3", "ansi4", "ansi5", "ansi2", "ansi1"];
function spaceColors() {
  const ids = new Set(spaces().map((p) => p.id));
  const stored = shared("space.colors") ?? {};
  const kept = Object.fromEntries(Object.entries(stored).filter(([id]) => ids.has(id)));
  let changed = Object.keys(kept).length !== Object.keys(stored).length;
  for (const p of spaces()) {
    if (kept[p.id] || p.name === "~") continue;
    const uses = (c) => Object.values(kept).filter((v) => v === c).length;
    kept[p.id] = PROJECT_COLORS.reduce((best, c) => (uses(c) < uses(best) ? c : best));
    changed = true;
  }
  if (changed) setShared("space.colors", kept);
  return kept;
}
function spaceColor(t, p) {
  if (p.name === "~") return t.dim;
  const c = spaceColors()[p.id] ?? PROJECT_COLORS[0];
  return c.startsWith("#") ? c : (MARK[c] ?? t[c]);
}

// cmd+p's status glyphs: a spinner while working, ○ idle, ● done or blocked
// (in that status's theme color), · for a tab with no agent.
function glyph(t, st) {
  if (st === "working") return svg("mods/workspace-chrome/spinner.svg").size(12).flex_none().text_color(t.working).spin(900);
  return div().w(12).flex_none().text_color(t[st] ?? t.dim).child(st === "idle" ? "○" : st ? "●" : "·");
}

export default class SpacesPicker extends View {
  init(_props, cx) {
    this.filter = "";
    this.at = null;
    this.hover = null;
    this.revealed = null;
    this.scroll = ScrollHandle.new();
    this.handle = cx.focus_handle();
    this.input = InputState.new({ placeholder: "Search spaces or type an index…" });
    this.input.on("change", (_e, cx) => {
      this.filter = this.input.value();
      this.hover = null;
      const list = this.shown();
      const active = list.findIndex((p) => p.active);
      this.at = active >= 0 ? active : 0;
      cx.notify();
    });
    this.input.on("submit", (_e, cx) => this.open(this.shown()[this.at], cx));
    this.input.focus();
    cx.timer.after(600, () => this.input.focus());
  }

  close() {
    closeOverlay(props().overlay);
  }

  // Spaces whose own fields match, or the one space whose index is typed
  // (0 is the first, the number shown on the left of each row).
  shown() {
    const f = this.filter.trim().toLowerCase();
    const all = spaces();
    if (!f) return all;
    if (/^\d+$/.test(f)) {
      const index = Number(f);
      return all.filter((p) => p.index - 1 === index);
    }
    return all.filter((p) => [p.name, p.folder ?? "", p.branch ?? "", p.machine ?? ""].join(" ").toLowerCase().includes(f));
  }

  // tab id -> the programs of the agents in it.
  agentsByTab() {
    const out = {};
    for (const a of agents()) {
      const tab = a.tab;
      if (!out[tab]) out[tab] = [];
      out[tab].push(a.program?.name ?? "agent");
    }
    return out;
  }

  open(space, cx) {
    if (!space) return;
    this.close();
    run("space.select", { id: space.id });
  }

  move(delta, cx) {
    const list = this.shown();
    if (!list.length) return;
    this.at = ((this.at ?? 0) + delta + list.length) % list.length;
    this.hover = null;
    cx.notify();
  }

  render() {
    const t = theme();
    const list = this.shown();
    if (this.at === null || this.at >= list.length) {
      const i = list.findIndex((p) => p.active);
      this.at = i >= 0 ? i : 0;
    }
    const sel = list[this.at];
    if (this.at !== this.revealed) {
      this.revealed = this.at;
      this.scroll.scroll_to_item(this.at);
    }
    // Hovering a space previews its tabs without moving the selection.
    const focus = list.find((p) => p.id === this.hover) ?? sel;
    const tabs = focus?.tabs ?? [];
    const byTab = this.agentsByTab();

    const label = (text) => div().h(16).text_size(11).font_semibold().text_color(t.dim).truncate().child(text);

    const spaceRow = (p) => {
      const on = p === sel;
      const hot = p.id === this.hover;
      return h_flex()
        .id(`spk-space-${p.id}`)
        .h(34)
        .flex_none()
        .mx(2)
        .px(9)
        .gap(9)
        .rounded(7)
        .items_center()
        .cursor_pointer()
        .when(on, (el) => el.bg(t.hover))
        .when(!on && hot, (el) => el.bg(t.raised))
        .hover((s) => s.bg(t.hover))
        .on_hover((hovered, cx) => {
          const next = hovered ? p.id : this.hover === p.id ? null : this.hover;
          if (next !== this.hover) {
            this.hover = next;
            cx.notify();
          }
        })
        .on_click(() => this.open(p))
        .child(div().w(13).flex_none().text_size(11).text_color(t.dim).child(String(p.index - 1)))
        .child(
          div().size(18).flex_none().rounded(5).bg(spaceColor(t, p)).flex().items_center().justify_center()
            .text_size(10.5).font_bold().text_color("#ffffff").child([...p.name][0]?.toUpperCase() ?? "?"),
        )
        .child(div().flex_1().truncate().text_size(12.5).when(p.active, (d) => d.font_semibold()).child(p.name))
        .when(p.machine, (el) => el.child(div().text_size(10.5).text_color(t.dim).child(p.machine)));
    };

    const tabRow = (c) => {
      const who = [...new Set(byTab[c.id] ?? [])].join(" · ");
      const here = focus?.active && c.active;
      return h_flex()
        .id(`spk-tab-${c.id}`)
        .h(30)
        .flex_none()
        .mx(2)
        .px(9)
        .gap(8)
        .rounded(6)
        .items_center()
        .cursor_pointer()
        .when(here, (el) => el.bg(t.raised))
        .hover((s) => s.bg(t.hover))
        .on_click(() => {
          this.close();
          run("tab.select", { id: c.id });
        })
        .child(glyph(t, c.status))
        .child(div().flex_1().truncate().text_size(12).when(here, (d) => d.font_semibold()).child(c.name))
        .when(c.settled, (el) => el.child(div().text_size(10.5).text_color(t.dim).child("settled")))
        .child(div().text_size(10.5).text_color(t.dim).child(who));
    };

    return v_flex()
      .id("spaces-picker")
      .track_focus(this.handle)
      .w_full()
      .min_h(0)
      .p(16)
      .gap(10)
      .bg(t.popover)
      .text_size(13)
      .on_key_down((e, cx) => {
        if (e.key === "escape") return this.close();
        if (e.key === "down") this.move(1, cx);
        else if (e.key === "up") this.move(-1, cx);
        else return;
        cx.stop_propagation();
      })
      .child(
        h_flex().items_center()
          .child(div().flex_1().text_size(15).font_semibold().text_color(t.foreground).child("Switch spaces"))
          .child(
            div().id("spk-esc").px(6).py(2).rounded(5).text_size(11).text_color(t.dim).cursor_pointer()
              .hover((s) => s.bg(t.hover).text_color(t.foreground))
              .on_click(() => this.close()).child("Esc"),
          ),
      )
      .child(
        h_flex().h(36).flex_none().px(10).gap(8).items_center().rounded(9).border_1().border_color(t.accent).bg(t.background)
          .child(svg("mods/workspace-chrome/search.svg").size(15).text_color(t.dim))
          .child(Input.new(this.input).flex_1().h_full().text_size(12.8).text_color(t.foreground)),
      )
      .child(
        h_flex().h(320).min_h(0).gap(12)
          .child(
            v_flex().w(300).flex_none().min_h(0).gap(6).p(8).rounded(9).border_1().border_color(t.border)
              .child(label(list.length ? `Spaces · ${list.length}` : "Spaces"))
              .child(
                list.length
                  ? v_flex().h(282).min_h(0).overflow_y_scrollbar().track_scroll(this.scroll).children(list.map(spaceRow))
                  : v_flex().h(282).items_center().justify_center()
                      .child(div().text_size(12).text_color(t.dim).child("No space matches your search")),
              ),
          )
          .child(
            v_flex().flex_1().min_w(0).min_h(0).gap(6).p(8).rounded(9).border_1().border_color(t.border)
              .child(label("Tabs"))
              .child(v_flex().h(282).min_h(0).overflow_y_scrollbar().children(tabs.map(tabRow))),
          ),
      )
      .child(div().text_size(11).text_color(t.dim).child("↑↓ move · Enter switch space · numbers pick by index (0 first) · hover shows tabs · click a tab to open it"));
  }
}
