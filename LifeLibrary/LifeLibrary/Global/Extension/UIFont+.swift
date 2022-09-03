//
//  UIFont+.swift
//  LifeLibrary
//
//  Created by 황윤경 on 2022/09/03.
//

import UIKit

extension UIFont {
    // Basic
    class func PretendardBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-Bold", size: size)!
    }

    class func PretendardRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-Regular", size: size)!
    }
    
    class func PretendardLight(size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-Light", size: size)!
    }
    
    // home
    @nonobjc class var home: UIFont{
        PretendardLight(size: 30)
    }
    
    // title
    @nonobjc class var title1: UIFont{
        PretendardLight(size: 24)
    }
    
    @nonobjc class var title2: UIFont{
        PretendardBold(size: 18)
    }
    
    @nonobjc class var title3: UIFont{
        PretendardBold(size: 16)
    }
    
    // body
    @nonobjc class var body1: UIFont{
        PretendardRegular(size: 18)
    }
    
    @nonobjc class var body2: UIFont{
        PretendardRegular(size: 16)
    }
    
    @nonobjc class var body3: UIFont{
        PretendardRegular(size: 13)
    }
}
