//
//  MyAlertViewController.swift
//  To_Do_App
//
//  Created by Mohamed Atallah on 06/11/2022.
//

import Foundation
import CleanyModal

class MyAlertViewController: CleanyAlertViewController {
    init(title: String?, message: String?, imageName: String? = nil, preferredStyle: CleanyAlertViewController.Style = .alert) {
        let styleSettings = CleanyAlertConfig.getDefaultStyleSettings()
        styleSettings[.tintColor] = .red
        styleSettings[.destructiveColor] = .systemPink
        super.init(title: title, message: message, imageName: imageName, preferredStyle: preferredStyle, styleSettings: styleSettings)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
