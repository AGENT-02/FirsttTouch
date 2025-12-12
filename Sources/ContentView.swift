import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.scenePhase) var scenePhase
    
    // Sort history by newest first
    @Query(sort: \DailyTouch.timestamp, order: .reverse) private var touches: [DailyTouch]
    
    @State private var justRecorded: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(uiColor: .systemGroupedBackground)
                    .ignoresSafeArea()
                
                if touches.isEmpty {
                    ContentUnavailableView(
                        "No Touches Yet",
                        systemImage: "hand.tap",
                        description: Text("Open the app tomorrow to record your first entry.")
                    )
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(touches) { touch in
                                TouchCard(touch: touch, isNew: isToday(touch.timestamp) && justRecorded)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("First Touch")
        }
        // Logic: Check when app opens or comes to foreground
        .onChange(of: scenePhase) { oldPhase, newPhase in
            if newPhase == .active {
                recordFirstTouchIfNeeded()
            }
        }
        .onAppear {
            recordFirstTouchIfNeeded()
        }
    }
    
    private func recordFirstTouchIfNeeded() {
        let now = Date()
        let calendar = Calendar.current
        
        // Check if we already have an entry for today
        let hasTouchForToday = touches.contains { touch in
            calendar.isDate(touch.timestamp, inSameDayAs: now)
        }
        
        if !hasTouchForToday {
            let newTouch = DailyTouch(timestamp: now)
            modelContext.insert(newTouch)
            
            // Success Haptics & Animation
            withAnimation {
                justRecorded = true
            }
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
    }
    
    private func isToday(_ date: Date) -> Bool {
        Calendar.current.isDateInToday(date)
    }
}
