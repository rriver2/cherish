//
//  Cherish.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

@main
struct CherishApp: App {
    @State var isSplashView = true
    
    var body: some Scene {
        WindowGroup {
            if isSplashView {
                LaunchScreenView()
                    .ignoresSafeArea()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                            isSplashView = false
                        }
                    }
            } else {
                ContentView()
                    .environmentObject(SoundViewModel())
                    .environmentObject(TimeLineViewModel())
                    .environmentObject(DarkModeViewModel())
                    .environmentObject(AddWritingPopupViewModel())
                    .onAppear {
                        print(isDeviceUnderiPhone7())
                    }
            }
        }
    }
}

struct LaunchScreenView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = UIStoryboard(name: "Launch Screen", bundle: nil).instantiateInitialViewController()!
        return controller
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
