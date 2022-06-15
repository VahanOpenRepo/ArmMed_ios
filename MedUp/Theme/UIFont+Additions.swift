//
//  UIFont+Additions.swift
//  MedUp
//
//  Created by Hrant on 09.05.21.
//

import UIKit

extension UIFont {

    class var aktivGroteskBold: UIFont {
        UIFont(name: "AktivGrotesk-Bold", size: 17.0)!
    }
    
    class var aktivGroteskRegular: UIFont {
        UIFont(name: "AktivGrotesk-Regular", size: 17.0)!
    }
    
    class var aktivGroteskMedium: UIFont {
        UIFont(name: "AktivGrotesk-Medium", size: 17.0)!
    }
    
    class var aktivGroteskLight: UIFont {
        UIFont(name: "AktivGrotesk-Light", size: 17.0)!
    }

    class var medSecondaryTitle: UIFont {
        UIFont(name: "NotoSansArmenian-Regular", size: 10) ?? UIFont().withSize(10)
    }

    class var medSubTitle: UIFont {
        UIFont(name: "NotoSansArmenian-Regular", size: 17) ?? UIFont().withSize(17)
    }
    
    class var medMedium: UIFont {
        UIFont(name: "NotoSansArmenian-Bold", size: 17) ?? UIFont().withSize(17)
    }
    
    class var medSubTitleBold: UIFont {
        UIFont(name: "NotoSansArmenian-Bold", size: 21) ?? UIFont().withSize(21)
    }

    class var medTitle: UIFont {
        UIFont(name: "NotoSansArmenian-Bold", size: 30) ?? UIFont().withSize(30)
    }
}
