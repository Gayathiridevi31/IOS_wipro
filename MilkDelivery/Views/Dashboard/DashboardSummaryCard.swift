import SwiftUI

struct DashboardSummaryCard: View {

    var title: String
    var value: String
    var icon: String
    var color: Color

    var body: some View {

        VStack(alignment: .leading, spacing: 15) {

            Image(systemName: icon)
                .font(.system(size: 25))
                .foregroundStyle(color)

            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text(value)
                .font(.title2)
                .bold()
                .foregroundStyle(.primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(uiColor: .secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
