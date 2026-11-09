// Cally — iOS home-screen widgets (WidgetKit + SwiftUI).
//
// This source is committed from Linux but is BUILT ON A MAC: add a Widget
// Extension target named "CallyWidget" in Xcode, add this file to it, and give
// both the app and the extension the App Group "group.com.cally.cally".
// See docs/BUILD-IOS.md for the exact steps. The Flutter side writes the data
// (title/grid/upcoming/todayCount) into that App Group via the home_widget
// plugin; this reads it back.

import WidgetKit
import SwiftUI

private let appGroupId = "group.com.cally.cally"

// MARK: - Shared data

struct Lbl: Decodable { let t: String; let c: Int; let a: Bool }
struct Cell: Decodable { let d: Int; let out: Bool; let today: Bool; let labels: [Lbl]; let more: Int }
struct UpItem: Decodable { let t: String; let s: Int; let c: Int; let a: Bool }

// Cally's event colour palette (keep in sync with lib/core/theme/tokens.dart).
private let palette: [Color] = [
    Color(red: 0.36, green: 0.42, blue: 0.94), // indigo
    Color(red: 0.10, green: 0.71, blue: 0.65), // teal
    Color(red: 0.20, green: 0.72, blue: 0.35), // green
    Color(red: 0.96, green: 0.65, blue: 0.14), // amber
    Color(red: 1.00, green: 0.48, blue: 0.27), // orange
    Color(red: 0.93, green: 0.31, blue: 0.55), // pink
    Color(red: 0.63, green: 0.36, blue: 0.94), // purple
    Color(red: 0.39, green: 0.45, blue: 0.55), // slate
]
private func colorFor(_ i: Int) -> Color { palette[((i % palette.count) + palette.count) % palette.count] }

struct CallyData {
    let title: String
    let grid: [Cell]
    let upcoming: [UpItem]
    let weekStart: Int // 1=Mon..7=Sun
    let themeMode: Int // 0 system, 1 light, 2 dark

    static func load() -> CallyData {
        let d = UserDefaults(suiteName: appGroupId)
        let title = d?.string(forKey: "title") ?? "CALLY"
        let grid = decode([Cell].self, d?.string(forKey: "grid")) ?? []
        let up = decode([UpItem].self, d?.string(forKey: "upcoming")) ?? []
        let ws = Int(d?.string(forKey: "weekStart") ?? "1") ?? 1
        let tm = Int(d?.string(forKey: "themeMode") ?? "0") ?? 0
        return CallyData(title: title, grid: grid, upcoming: up, weekStart: ws, themeMode: tm)
    }

    private static func decode<T: Decodable>(_ type: T.Type, _ s: String?) -> T? {
        guard let s = s, let data = s.data(using: .utf8) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}

// MARK: - Timeline

struct Entry: TimelineEntry { let date: Date; let data: CallyData }

struct Provider: TimelineProvider {
    func placeholder(in: Context) -> Entry { Entry(date: Date(), data: CallyData.load()) }
    func getSnapshot(in: Context, completion: @escaping (Entry) -> Void) {
        completion(Entry(date: Date(), data: CallyData.load()))
    }
    func getTimeline(in: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        // Rebuild at the next midnight; the app also reloads after every edit.
        let next = Calendar.current.nextDate(after: Date(), matching: DateComponents(hour: 0),
                                             matchingPolicy: .nextTime) ?? Date().addingTimeInterval(3600)
        completion(Timeline(entries: [Entry(date: Date(), data: CallyData.load())], policy: .after(next)))
    }
}

// MARK: - Theme

/// Forces the widget to match the app's theme (system / light / dark) rather
/// than only the device appearance, and paints a matching background.
private struct Themed<Content: View>: View {
    let mode: Int
    @ViewBuilder let content: Content
    var body: some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemBackground))
            .modifier(SchemeOverride(mode: mode))
    }
}

private struct SchemeOverride: ViewModifier {
    let mode: Int
    func body(content: Content) -> some View {
        switch mode {
        case 1: return AnyView(content.environment(\.colorScheme, .light))
        case 2: return AnyView(content.environment(\.colorScheme, .dark))
        default: return AnyView(content)
        }
    }
}

// MARK: - Views

/// A small event label, minical-style: a soft tinted pill with the event
/// title in its colour, ellipsised to one line so long names still fit.
struct Chip: View {
    let label: Lbl
    var body: some View {
        Text(label.t)
            .font(.system(size: 8, weight: .medium))
            .lineLimit(1)
            .truncationMode(.tail)
            .foregroundColor(colorFor(label.c))
            .padding(.horizontal, 3)
            .padding(.vertical, 0.5)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(RoundedRectangle(cornerRadius: 3).fill(colorFor(label.c).opacity(0.22)))
    }
}

/// One day cell: the date, then up to three event chips and a "+N" overflow.
struct CellView: View {
    let cell: Cell
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            Text("\(cell.d)")
                .font(.system(size: 10, weight: cell.today ? .bold : .regular))
                .foregroundColor(cell.out ? .secondary.opacity(0.4) : (cell.today ? .white : .primary))
                .frame(width: 15, height: 15)
                .background(cell.today ? Color.accentColor : .clear)
                .clipShape(Circle())
            ForEach(Array(cell.labels.prefix(3).enumerated()), id: \.offset) { _, l in
                Chip(label: l)
            }
            if cell.more > 0 {
                Text("+\(cell.more)")
                    .font(.system(size: 7, weight: .semibold))
                    .foregroundColor(.secondary)
                    .padding(.leading, 2)
            }
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, minHeight: 46, alignment: .topLeading)
        .opacity(cell.out ? 0.5 : 1)
    }
}

struct MonthGridView: View {
    let data: CallyData
    private let cols = Array(repeating: GridItem(.flexible(), spacing: 2), count: 7)

    // Localised one-letter weekday headers, ordered by the app's week start.
    private var weekdaySymbols: [String] {
        let base = DateFormatter().veryShortStandaloneWeekdaySymbols
            ?? ["S", "M", "T", "W", "T", "F", "S"]
        let sundayFirst = data.weekStart % 7 // Mon(1)->1 … Sat(6)->6, Sun(7)->0
        return (0..<7).map { base[(sundayFirst + $0) % base.count] }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(data.title).font(.caption).bold().foregroundColor(.primary)
            HStack(spacing: 2) {
                ForEach(Array(weekdaySymbols.enumerated()), id: \.offset) { _, s in
                    Text(s)
                        .font(.system(size: 9, weight: .semibold))
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                }
            }
            LazyVGrid(columns: cols, spacing: 2) {
                ForEach(Array(data.grid.enumerated()), id: \.offset) { _, c in
                    CellView(cell: c)
                }
            }
        }
        .padding(10)
        .widgetURL(URL(string: "cally://today"))
    }
}

struct UpcomingView: View {
    let data: CallyData
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Upcoming").font(.caption).bold()
            ForEach(Array(data.upcoming.prefix(4).enumerated()), id: \.offset) { _, e in
                HStack(spacing: 6) {
                    RoundedRectangle(cornerRadius: 2).fill(colorFor(e.c)).frame(width: 3, height: 16)
                    Text(e.t).font(.system(size: 13)).lineLimit(1)
                    Spacer()
                    Text(Date(timeIntervalSince1970: Double(e.s) / 1000),
                         style: e.a ? .date : .time).font(.system(size: 12)).foregroundColor(.secondary)
                }
            }
            Spacer(minLength: 0)
        }
        .padding(12)
        .widgetURL(URL(string: "cally://today"))
    }
}

// MARK: - Widgets

// The biggest month grid the device offers: extra-large on iPad, large on iPhone.
private var monthFamilies: [WidgetFamily] {
    if #available(iOSApplicationExtension 15.0, *) {
        return [.systemLarge, .systemExtraLarge]
    }
    return [.systemLarge]
}

struct CallyMonthWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "CallyMonthWidget", provider: Provider()) { e in
            Themed(mode: e.data.themeMode) { MonthGridView(data: e.data) }
        }
        .configurationDisplayName("Month")
        .description("This month at a glance.")
        .supportedFamilies(monthFamilies)
    }
}

struct CallyUpcomingWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "CallyUpcomingWidget", provider: Provider()) { e in
            Themed(mode: e.data.themeMode) { UpcomingView(data: e.data) }
        }
        .configurationDisplayName("Upcoming")
        .description("Your next events.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

@main
struct CallyWidgetBundle: WidgetBundle {
    var body: some Widget {
        CallyMonthWidget()
        CallyUpcomingWidget()
    }
}
