//
//  SwiftUIView.swift
//  Todo List
//
//  Created by Hazo Baykulov on 28.09.2026.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var opacity: Double = 0.0
    @State private var scale: Double = 0.8
    
    
    var body: some View {
        ZStack {
            Color("ButterYellow")
                .ignoresSafeArea()
            
            Image(systemName: "map")
                .resizable()
                .frame(width: 140, height: 140)
                .aspectRatio(contentMode: .fill)
                .scaleEffect(scale)
                .opacity(opacity)
                .foregroundStyle(.royalIris)

        }
        .onAppear {
            withAnimation(.spring(duration: 0.8)) {
                opacity = 1.0
                scale = 1.0
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
