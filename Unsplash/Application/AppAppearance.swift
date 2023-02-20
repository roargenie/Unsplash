//
//  AppAppearance.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/20.
//

import UIKit

final class AppAppearance {

    static func setupAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        appearance.shadowColor = nil
        
        let backImage = UIImage(systemName: "chevron.backward")
        appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = .label
        UINavigationBar.appearance().barTintColor = .label

    }
}
