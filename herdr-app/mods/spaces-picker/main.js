// Spaces picker: jump to a space by its letter. Every space gets a random
// unique letter (a–z, then A–Z) shown in a boxed chip; pressing it switches
// there at once. ↑↓ moves the selection, Enter switches to it, and the right
// column follows the hovered or selected space with its tabs, agent status and
// program, like cmd+p. Clicking a tab goes straight to it. Opened from the tmux
// prefix (Ctrl+Space, then s) or with
// `herdr-app do mod.open --name spaces-picker`.

import { View, div, svg } from "gpui-kit";
import { v_flex, h_flex, ScrollHandle } from "gpui-base";
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

// Jump letters: all of a–z first, then A–Z only once lowercase runs out;
// case-sensitive, 52 spaces at most. Past that a space simply gets no letter
// (and is still reachable with ↑↓ and Enter).
const LOWER = [..."abcdefghijklmnopqrstuvwxyz"];
const UPPER = [..."ABCDEFGHIJKLMNOPQRSTUVWXYZ"];

// Letters last for the app session: reopening the picker shows the same ones,
// a closed space gives its letter back, and only a mod reload reshuffles.
const HINTS = {};

// cmd+p's status glyphs: a spinner while working, ○ idle, ● done or blocked
// (in that status's theme color), · for a tab with no agent.
function glyph(t, st) {
  if (st === "working") return svg("mods/workspace-chrome/spinner.svg").size(12).flex_none().text_color(t.working).spin(900);
  return div().w(12).flex_none().text_color(t[st] ?? t.dim).child(st === "idle" ? "○" : st ? "●" : "·");
}

export default class SpacesPicker extends View {
  init(_props, cx) {
    this.at = null;
    this.hover = null;
    this.revealed = null;
    this.scroll = ScrollHandle.new();
    this.handle = cx.focus_handle();
    this.handle.focus();
  }

  close() {
    closeOverlay(props().overlay);
  }

  // One random, unused letter per space, kept for the session (a space that
  // goes away gives its letter back). Lowercase is used up before any
  // uppercase appears.
  assign(list) {
    const ids = new Set(list.map((p) => p.id));
    for (const id of Object.keys(HINTS)) if (!ids.has(id)) delete HINTS[id];
    const used = new Set(Object.values(HINTS));
    const lower = LOWER.filter((c) => !used.has(c));
    const upper = UPPER.filter((c) => !used.has(c));
    for (const p of list) {
      if (HINTS[p.id]) continue;
      const pool = lower.length ? lower : upper;
      if (!pool.length) break;
      HINTS[p.id] = pool.splice(Math.floor(Math.random() * pool.length), 1)[0];
    }
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

  open(space) {
    if (!space) return;
    this.close();
    run("space.select", { id: space.id });
  }

  move(delta, cx) {
    const list = spaces();
    if (!list.length) return;
    this.at = ((this.at ?? 0) + delta + list.length) % list.length;
    this.hover = null;
    cx.notify();
  }

  // The character a keypress would type, or null for a chord (so ctrl/alt/cmd
  // combinations never jump).
  typed(e) {
    const m = e.modifiers;
    if (m.control || m.alt || m.platform) return null;
    const ch = e.key_char ?? (m.shift && e.key.length === 1 ? e.key.toUpperCase() : e.key);
    return ch && ch.length === 1 ? ch : null;
  }

  render() {
    const t = theme();
    const list = spaces();
    this.assign(list);
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

    // The jump letter: outlined in the same accent the focused pane's border
    // uses, so a theme or layout changes it in one place.
    const hint = (p) => {
      const ch = HINTS[p.id];
      if (!ch) return null;
      return div().size(20).flex_none().rounded(5).border_1().border_color(t.accent)
        .flex().items_center().justify_center().text_size(11.5).font_semibold().text_color(t.accent)
        .child(ch);
    };

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
        .when(Boolean(HINTS[p.id]), (el) => el.child(hint(p)))
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
        else if (e.key === "enter") this.open(sel);
        else {
          const ch = this.typed(e);
          const space = ch && list.find((p) => HINTS[p.id] === ch);
          if (!space) return;
          this.open(space);
        }
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
        h_flex().h(332).min_h(0).gap(12)
          .child(
            v_flex().w(300).flex_none().min_h(0).gap(6).p(8).rounded(9).border_1().border_color(t.border)
              .child(label(list.length ? `Spaces · ${list.length}` : "Spaces"))
              .child(
                list.length
                  ? v_flex().h(294).min_h(0).overflow_y_scrollbar().track_scroll(this.scroll).children(list.map(spaceRow))
                  : v_flex().h(294).items_center().justify_center()
                      .child(div().text_size(12).text_color(t.dim).child("No spaces")),
              ),
          )
          .child(
            v_flex().flex_1().min_w(0).min_h(0).gap(6).p(8).rounded(9).border_1().border_color(t.border)
              .child(label("Tabs"))
              .child(v_flex().h(294).min_h(0).overflow_y_scrollbar().children(tabs.map(tabRow))),
          ),
      )
      .child(div().text_size(11).text_color(t.dim).child("↑↓ move · Enter switch · press a space's letter to jump · hover shows tabs · click a tab to open it"));
  }
}
