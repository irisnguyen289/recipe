//
//  StoryCirleView.swift
//  recipe
//
//  Created by mac on 2/15/21.
//

import SwiftUI

struct StoryCircleView: View {
    var body: some View {
        Image(systemName: "circle.grid.hex")
            .frame(width: 60, height: 60)
            .background(Color.init(red: 0.95, green: 0.95, blue: 0.95))
            .foregroundColor(.black)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.black, lineWidth: 3))
    }
}

struct StoryCircleView_Previews: PreviewProvider {
    static var previews: some View {
        StoryCircleView()
    }
}
