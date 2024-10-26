import SwiftUI

struct EmptyState: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                content
                Spacer()
            }
            .padding()
        }
    }

    private var content: some View {
        VStack {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)

            Text("Begin Your Journal")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .foregroundColor(.purple1)
                .padding(.top)

            Text("Craft your personal diary, tap the plus icon to begin")
                .font(.system(size: 18))
                .fontWeight(.light)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

#Preview {
    EmptyState()
}
