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
                // To use CircleStrokeSpin just construct it
                CircleStrokeSpin()
                // You can change color and linewidth.
                // Unforunately, color should be CGColor
                // and .foregroundColor modifier is not supported
                CircleStrokeSpin(isLoading: true, color: UIColor.cyan.cgColor, lineWidth: 10)
            }.padding()
            HStack {
                // If isLoading is false, the view is hidden but still occupies space
                CircleStrokeSpin(isLoading: false)
                // You can set the size of the CircleStrokeSpin view via frame modifier
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
