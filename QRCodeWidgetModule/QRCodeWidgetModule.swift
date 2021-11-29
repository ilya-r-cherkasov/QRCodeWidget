//
//  QRCodeWidgetModule.swift
//  QRCodeWidgetModule
//
//  Created by Ilya Cherkasov on 29.11.2021.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), image: UIImage(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), image: UIImage(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        var image = UIImage()
        
        if let userDefaults = UserDefaults(suiteName: "group.qrCodeSuite"),
           let data = userDefaults.object(forKey: "qrcode") as? Data {
            image = UIImage(data: data)!
        }
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, image: image, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let image: UIImage
    let configuration: ConfigurationIntent
}

struct QRCodeWidgetModuleEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Image(uiImage: entry.image)
            .resizable()
            .scaledToFill()
    }
}

@main
struct QRCodeWidgetModule: Widget {
    let kind: String = "QRCodeWidgetModule"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            QRCodeWidgetModuleEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct QRCodeWidgetModule_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeWidgetModuleEntryView(
            entry: SimpleEntry(
                date: Date(),
                image: UIImage(),
                configuration: ConfigurationIntent()
            )
        )
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
