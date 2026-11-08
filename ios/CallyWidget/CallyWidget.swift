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

struct Cell: Decodable { let d: Int; let out: Bool; let today: Bool; let dots: [Int]; let more: Int }
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

    static func load() -> CallyData {
        let d = UserDefaults(suiteName: appGroupId)
        let title = d?.string(forKey: "title") ?? "CALLY"
        let grid = decode([Cell].self, d?.string(forKey: "grid")) ?? []
        let up = decode([UpItem].self, d?.string(forKey: "upcoming")) ?? []
        return CallyData(title: title, grid: grid, upcoming: up)
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

// MARK: - Views

struct MonthGridView: View {
    let data: CallyData
    private let cols = Array(repeating: GridItem(.flexible(), spacing: 2), count: 7)

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(data.title).font(.caption).bold().foregroundColor(.primary)
            LazyVGrid(columns: cols, spacing: 2) {
                ForEach(Array(data.grid.enumerated()), id: \.offset) { _, c in
                    VStack(spacing: 1) {
                        Text("\(c.d)")
                            .font(.system(size: 9))
                            .foregroundColor(c.out ? .secondary.opacity(0.4) : (c.today ? .white : .primary))
                            .frame(width: 16, height: 16)
                            .background(c.today ? Color.accentColor : .clear)
                            .clipShape(Circle())
                        HStack(spacing: 1) {
                            ForEach(c.dots.prefix(3), id: \.self) { Circle().fill(colorFor($0)).frame(width: 4, height: 4) }
                        }
                    }
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

struct CallyMonthWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "CallyMonthWidget", provider: Provider()) { e in
            MonthGridView(data: e.data)
        }
        .configurationDisplayName("Month")
        .description("This month at a glance.")
        .supportedFamilies([.systemLarge])
    }
}

struct CallyUpcomingWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "CallyUpcomingWidget", provider: Provider()) { e in
            UpcomingView(data: e.data)
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
