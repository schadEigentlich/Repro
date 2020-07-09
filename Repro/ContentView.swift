//
//  ContentView.swift
//  Repro
//
//  Created by Daniel Gstoehl on 19.06.20.
//  Copyright © 2020 Ubique. All rights reserved.
//

import SwiftUI
import ReproducibleLibrary
import AnotherLibrary

struct ContentView: View {
    var body: some View {
//        Text(hello(message: "World"))
        VStack {
            Text(hello(message: "function"))
            Text(ReproLib(_greeting: "Hello ").hello(message: "class"))
            Text(AnotherLibrary().text)
            ReproLib2(_greeting: "Repro2").helloText(message: "with inheritance")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
