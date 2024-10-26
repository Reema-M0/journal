import SwiftUI

struct NewJournal: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var journalTitle: String = ""
    @State private var journalContent: String = ""
    
    private var currentDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: Date())
    }

    var onSave: ((String, String) -> Void)?
    var title: String = ""
    var content: String = ""

    var body: some View {
        VStack {
            Spacer().frame(height: 30)

            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                        .foregroundColor(.purple1)
                }
                Spacer()
                Button(action: {
                    onSave?(journalTitle, journalContent)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                        .foregroundColor(.purple1)
                }
            }
            .padding()

            VStack(alignment: .leading) {
                TextField("Title", text: $journalTitle)
                    .font(.largeTitle)
                    .foregroundColor(.purple1)
                    .padding(.bottom, 5)

                Text(currentDate)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom)

                TextField("Type your Journal…", text: $journalContent)
                    .textFieldStyle(PlainTextFieldStyle())
                    .foregroundColor(.white)
                    .padding(.bottom, 5.0)

                Spacer()
            }
            .padding(.horizontal)
            .onAppear {
                journalTitle = title
                journalContent = content
            }
        }
        .padding()
        .background(Color(hex: "1A1A1C"))
        .ignoresSafeArea()
    }
}

#Preview {
    NewJournal()
}
