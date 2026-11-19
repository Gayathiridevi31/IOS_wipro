import SwiftUI

struct TodayDeliveryStatusView: View {

    var status: String

    var statusColor: Color {

        switch status {
        case "Delivered":
            return .green

        case "Skipped":
            return .red

        case "Partially Delivered":
            return .orange

        default:
            return .gray
        }
    }

    var body: some View {

        VStack(alignment: .leading, spacing: 15) {

            Text("Today's Delivery")
                .font(.headline)

            HStack {

                Image(systemName: "calendar")
                    .font(.title2)
                    .foregroundStyle(statusColor)

                VStack(alignment: .leading, spacing: 5) {

                    Text(status)
                        .font(.headline)
                        .foregroundStyle(statusColor)

                    Text(Date.now.formatted(
                        date: .long,
                        time: .omitted
                    ))
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(uiColor: .secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
