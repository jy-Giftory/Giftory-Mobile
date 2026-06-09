import WidgetKit
import SwiftUI

// 앱과 공유하는 App Group (Dvart의 WidgetService._appGroupId 와 동일해야 함)
let appGroupId = "group.com.example.giftory.widget"

struct GiftoryEntry: TimelineEntry {
    let date: Date
    let title: String
    let dday: String
    let subtitle: String
}

struct GiftoryProvider: TimelineProvider {
    func placeholder(in context: Context) -> GiftoryEntry {
        GiftoryEntry(date: Date(), title: "기념일", dday: "D-0", subtitle: "")
    }

    func getSnapshot(in context: Context, completion: @escaping (GiftoryEntry) -> Void) {
        completion(readEntry())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<GiftoryEntry>) -> Void) {
        let entry = readEntry()
        // 30분마다 갱신
        let next = Calendar.current.date(byAdding: .minute, value: 30, to: Date())!
        completion(Timeline(entries: [entry], policy: .after(next)))
    }

    private func readEntry() -> GiftoryEntry {
        let prefs = UserDefaults(suiteName: appGroupId)
        let title = prefs?.string(forKey: "title") ?? "등록된 기념일이 없어요"
        let dday = prefs?.string(forKey: "dday") ?? ""
        let subtitle = prefs?.string(forKey: "subtitle") ?? "기념일을 추가해보세요"
        return GiftoryEntry(date: Date(), title: title, dday: dday, subtitle: subtitle)
    }
}

struct GiftoryWidgetEntryView: View {
    var entry: GiftoryProvider.Entry

    // 디자인 시스템 색상 (moca)
    let moca500 = Color(red: 0.643, green: 0.471, blue: 0.392)
    let moca100 = Color(red: 0.925, green: 0.859, blue: 0.835)
    let moca800 = Color(red: 0.298, green: 0.208, blue: 0.169)
    let moca950 = Color(red: 0.165, green: 0.110, blue: 0.086)
    let gray500 = Color(red: 0.471, green: 0.471, blue: 0.471)

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("다가오는 기념일")
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(moca500)

            Text(entry.title)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(moca950)
                .lineLimit(1)

            if !entry.dday.isEmpty {
                Text(entry.dday)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(moca800)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(moca100)
                    .clipShape(Capsule())
            }

            Text(entry.subtitle)
                .font(.system(size: 11))
                .foregroundColor(gray500)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding(16)
    }
}

struct GiftoryWidget: Widget {
    let kind: String = "GiftoryWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: GiftoryProvider()) { entry in
            if #available(iOS 17.0, *) {
                GiftoryWidgetEntryView(entry: entry)
                    .containerBackground(.white, for: .widget)
            } else {
                GiftoryWidgetEntryView(entry: entry)
                    .background(Color.white)
            }
        }
        .configurationDisplayName("Giftory 기념일")
        .description("가장 가까운 기념일의 D-Day를 보여줍니다.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
