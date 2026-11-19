
import SwiftUI
import SwiftData

struct AddDeliveryView: View {

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var viewModel = AddDeliveryViewModel()

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

                TextField("Rate per item (₹)", text: $viewModel.rate)
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
                    "Enter notes (optional)",
                    text: $viewModel.notes,
                    axis: .vertical
                )
                .lineLimit(3...5)
            }

            Section {

                Button {
                    let saved = viewModel.saveDelivery(
                        context: modelContext
                    )

                    if saved {
                        dismiss()
                    }
                } label: {
                    HStack {
                        Spacer()
                        Text("Save Delivery")
                            .fontWeight(.semibold)
                        Spacer()
                    }
                }
            }
        }
        .navigationTitle("Add Delivery")
        .navigationBarTitleDisplayMode(.inline)
        .alert(
            "Error",
            isPresented: Binding(
                get: { !viewModel.errorMessage.isEmpty },
                set: { if !$0 { viewModel.errorMessage = "" } }
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

