
//
//  CustomCircleLoader.swift
//  Navigate
//
//  Created by Aakif Nadeem on 06/02/2023.
//

import Foundation
import SwiftUI

struct CustomCircleLoader<Content>: View where Content: View {
    
    // MARK:- variables
    let circleTrackGradient = LinearGradient(gradient: .init(colors: [Color.circleLoaderColor]), startPoint: .leading, endPoint: .bottomLeading)
    let circleRoundGradient = LinearGradient(gradient: .init(colors: [Color.circleRoundStart, Color.circleLoaderColor]), startPoint: .topLeading, endPoint: .trailing)
    
    let trackerRotation: Double = 2
    let animationDuration: Double = 0.75
    
    @State var isAnimating: Bool = false
    @State var circleStart: CGFloat = 0.17
    @State var circleEnd: CGFloat = 0.325
    
    @State var rotationDegree: Angle = Angle.degrees(0)
    
    @Binding var isShowing: Bool
    var width: CGFloat = 80
    var height: CGFloat = 80
    var lineWidth: CGFloat = 8
    var content: () -> Content
    
    // MARK:- views
    var body: some View {
        ZStack(alignment: .center) {
            
            self.content()
                .disabled(self.isShowing)
            
            BlurView(radius: 5)
                .opacity(isShowing ? 1 : 0)
            
            ZStack {
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 12))
                    .fill(circleTrackGradient)
                Circle()
                    .trim(from: circleStart, to: circleEnd)
                    .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                    .fill(circleRoundGradient)
                    .rotationEffect(self.rotationDegree)
            }
            .frame(width: width, height: height)
            .onAppear() {
                if isShowing {
                    self.animateLoader()
                    Timer.scheduledTimer(withTimeInterval: self.trackerRotation * self.animationDuration + (self.animationDuration), repeats: true) { (mainTimer) in
                        self.animateLoader()
                    }
                }
            }
            .opacity(isShowing ? 1 : 0)
        }
    }
    
    // MARK:- functions
    func getRotationAngle() -> Angle {
        return .degrees(360 * self.trackerRotation) + .degrees(120)
    }
    
    func animateLoader() {
        withAnimation(Animation.spring(response: animationDuration * 2 )) {
            self.rotationDegree = .degrees(-57.5)
        }
        
        Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: false) { _ in
            withAnimation(Animation.easeInOut(duration: self.trackerRotation * self.animationDuration)) {
                self.rotationDegree += self.getRotationAngle()
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: animationDuration * 1.25, repeats: false) { _ in
            withAnimation(Animation.easeOut(duration: (self.trackerRotation * self.animationDuration) / 2.25 )) {
                self.circleEnd = 0.925
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: trackerRotation * animationDuration, repeats: false) { _ in
            self.rotationDegree = .degrees(47.5)
            withAnimation(Animation.easeOut(duration: self.animationDuration)) {
                self.circleEnd = 0.325
            }
        }
    }
}

#Preview {
    CustomCircleLoader(isShowing: .constant(true)) {
        NavigationView {
            List(["1", "2", "3", "4", "5"], id: \.self) { row in
                Text(row)
            }.navigationBarTitle(Text("Loader Test"), displayMode: .large)
        }
    }
}


//BlurView
struct BlurView: View {
    let radius: CGFloat
    
    @ViewBuilder
    var body: some View {
        BackdropView().blur(radius: radius)
    }
}

//MARK: Blur
struct BackdropView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView()
        let blur = UIBlurEffect(style: .extraLight)
        let animator = UIViewPropertyAnimator()
        animator.addAnimations { view.effect = blur }
        animator.fractionComplete = 0
        animator.stopAnimation(true)
        animator.finishAnimation(at: .start)
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) { }
    
}
