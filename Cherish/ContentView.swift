//
//  ContentView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            WritingMainView()
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("writing")
                }.tag(0)
            TimelineView()
                .tabItem {
                    Image(systemName: "books.vertical")
                    Text("timeline")
                }.tag(1)
        }
        .accentColor(.black)
        .environmentObject(SoundViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
