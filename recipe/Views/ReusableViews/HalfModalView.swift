//
//  HalfModelView.swift
//  recipe
//
//  Created by mac on 2/24/21.
//

import SwiftUI

struct HalfModalView<Content: View>: View {
    @GestureState private var dragState = DragState.inactive
    @Binding var isShown: Bool
    
    var modalHeight: CGFloat = 400
    
    private func onDragEnded(drag: DragGesture.Value){
        let dragThreshold = modalHeight * 2 / 3
        if drag.predictedEndTranslation.height > dragThreshold || drag.translation.height > dragThreshold{
            isShown = false
        }
    }
    
    var content: () -> Content
    var body: some View {
        let drag = DragGesture().updating($dragState){
            drag, state, transaction in
            state = .dragging(translation: drag.translation)
        }.onEnded(onDragEnded)
        
        return Group {
            ZStack{
                // Background
                Spacer()
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                    .background(isShown ? Color.black.opacity(0.5 * fraction_progress(lowerLimit: 0, upperLimit: Double(modalHeight), current: Double(dragState.translation.height), inverted: true)) : Color.clear)
                    .animation(.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
                    .gesture(
                        TapGesture()
                            .onEnded { _ in
                                self.isShown = false
                            }
                    )
                // Foreground
                VStack{
                    Spacer()
                    ZStack{
                        Color.white.opacity(1.0)
                            .frame(width: UIScreen.main.bounds.size.width, height: modalHeight)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        
                        self.content()
                            .padding()
                            .padding(.bottom, 65)
                            .frame(width: UIScreen.main.bounds.size.width, height: modalHeight)
                            .clipped()
                    }.offset(y: isShown ? ((self.dragState.isDragging && dragState.translation.height >= 1) ? dragState.translation.height : 0) : modalHeight)
                    .animation(.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
                    .gesture(drag)
                }
            }
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
}
