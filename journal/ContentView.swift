import SwiftUI

struct ContentView: View {
    @State private var navigateToMainPage = false

    var body: some View {
        ZStack {
            Image("Background1")
                .ignoresSafeArea()
        
            VStack {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 77.7, height: 101)
                
                Text("Journali")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .font(.system(size: 42))
                
                Text("Your thoughts, your story")
                    .font(.system(size: 18))
                    .fontWeight(.light)
                    .foregroundColor(.white)
            }
            .padding()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                navigateToMainPage = true
            }
        }
        .fullScreenCover(isPresented: $navigateToMainPage) {
            MainPage()
        }
    }
}

#Preview {
    ContentView()
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        var rgbValue: UInt64 = 0
        
        Scanner(string: hex).scanHexInt64(&rgbValue)
        
        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}
