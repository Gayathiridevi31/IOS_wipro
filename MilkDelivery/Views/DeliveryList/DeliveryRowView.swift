import SwiftUI

struct DeliveryRowView: View {

    var delivery: Delivery

    var body: some View {

        HStack(spacing: 15) {

            Image(
                systemName: delivery.item == "Milk"
                ? "drop.fill"
                : "newspaper.fill"
            )
            .font(.title2)
            .foregroundStyle(
                delivery.item == "Milk"
                ? .blue
                : .orange
            )
            .frame(width: 45, height: 45)
            .background(
                delivery.item == "Milk"
                ? Color.blue.opacity(0.12)
                : Color.orange.opacity(0.12)
            )
            .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 6) {

                Text(delivery.item)
                    .font(.headline)
                    .foregroundStyle(.primary)

                Text(
                    delivery.date.formatted(
                        date: .abbreviated,
                        time: .omitted
                    )
                )
                .font(.caption)
                .foregroundStyle(.secondary)

                Text("Quantity: \(delivery.quantity)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 8) {

                Text(
                    delivery.totalAmount.formatted(
                        .currency(code: "INR")
                        .locale(Locale(identifier: "en_IN"))
                    )
                )
                .font(.headline)

                Text(delivery.status)
                    .font(.caption)
                    .bold()
                    .foregroundStyle(
                        delivery.status == "Delivered"
                        ? .green
                        : .red
                    )
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(
                        delivery.status == "Delivered"
                        ? Color.green.opacity(0.12)
                        : Color.red.opacity(0.12)
                    )
                    .clipShape(Capsule())
            }
        }
        .padding(.vertical, 8)
    }
}
