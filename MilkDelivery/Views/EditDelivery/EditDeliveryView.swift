
import SwiftUI
import SwiftData

struct EditDeliveryView: View {

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var viewModel: EditDeliveryViewModel

    init(delivery: Delivery) {
        _viewModel = State(
            initialValue: EditDeliveryViewModel(delivery: delivery)
        )
    }

    var body: some View {

        Form {

            Section("Delivery Information") {

                DatePicker(
                    "Delivery Date",
                    selection: $viewModel.date,
                    displayedComponents: .date
                )

                Picker("Item", selection: $viewModel.item) {
                    Text("Milk").tag("Milk")
                    Text("Newspaper").tag("Newspaper")
                }

                Stepper(
                    "Quantity: \(viewModel.quantity)",
                    value: $viewModel.quantity,
                    in: 1...100
                )

                TextField(
                    "Rate per item (₹)",
                    text: $viewModel.rate
                )
                .keyboardType(.decimalPad)
            }

            Section("Delivery Status") {

                Picker("Status", selection: $viewModel.status) {
                    Text("Delivered").tag("Delivered")
                    Text("Skipped").tag("Skipped")
                }
                .pickerStyle(.segmented)
            }

            Section("Additional Notes") {

                TextField(
                    "Enter notes",
                    text: $viewModel.notes,
                    axis: .vertical
                )
                .lineLimit(3...5)
            }

            Section {

                Button {
                    let updated = viewModel.updateDelivery(
                        context: modelContext
                    )

                    if updated {
                        dismiss()
                    }
                } label: {
                    HStack {
                        Spacer()
                        Text("Update Delivery")
                            .fontWeight(.semibold)
                        Spacer()
                    }
                }
            }
        }
        .navigationTitle("Edit Delivery")
        .navigationBarTitleDisplayMode(.inline)
        .alert(
            "Error",
            isPresented: Binding(
                get: { !viewModel.errorMessage.isEmpty },
                set: {
                    if !$0 {
                        viewModel.errorMessage = ""
                    }
                }
            )
        ) {
            Button("OK") {
                viewModel.errorMessage = ""
            }
        } message: {
            Text(viewModel.errorMessage)
        }
    }
}

