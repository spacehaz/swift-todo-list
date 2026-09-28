import SwiftUI
import SwiftData

@main struct MyApp: App {
    
    @State private var showSplash: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                
                
                if showSplash {
                    SplashScreenView()
                        
                }
            }
            .task {
                try? await Task.sleep(for: .seconds(2))
                showSplash = false
            }
        }
        .modelContainer(for: Todo.self)
    }
}


