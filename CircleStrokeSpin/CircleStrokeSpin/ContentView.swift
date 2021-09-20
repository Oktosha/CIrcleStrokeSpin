//
//  ContentView.swift
//  CircleStrokeSpin
//
//  Created by Daria Kolodzey on 9/20/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                CircleStrokeSpin()
                CircleStrokeSpin(isLoading: true, color: UIColor.cyan.cgColor, lineWidth: 10)
            }.padding()
            HStack {
                CircleStrokeSpin(isLoading: false)
                CircleStrokeSpin().frame(width: 20, height: 20)
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
