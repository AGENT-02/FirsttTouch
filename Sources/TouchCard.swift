import SwiftUI

struct TouchCard: View {
    let touch: DailyTouch
    let isNew: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(touch.dateString)
                    .font(.caption)
                    .textCase(.uppercase)
                    .foregroundStyle(.secondary)
                
                Text("Opened at \(touch.timeString)")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
            }
            
            Spacer()
            
            Image(systemName: "clock.badge.checkmark")
                .font(.title2)
                .foregroundStyle(isNew ? .green : .blue)
                .symbolEffect(.bounce, value: isNew)
        }
        .padding()
        .background(Color(uiColor: .secondarySystemGroupedBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isNew ? Color.green : Color.clear, lineWidth: 2)
        )
    }
}
