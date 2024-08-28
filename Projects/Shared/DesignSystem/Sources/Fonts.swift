//
//  Font.swift
//  SharedDesignSystem
//
//  Created by 지연 on 8/28/24.
//

import UIKit

public struct Fonts {
    public static func black(size: CGFloat) -> UIFont {
        return SharedDesignSystemFontFamily.Pretendard.black.font(size: size)
    }
    
    public static func bold(size: CGFloat) -> UIFont {
        return SharedDesignSystemFontFamily.Pretendard.bold.font(size: size)
    }
    
    public static func extraBold(size: CGFloat) -> UIFont {
        return SharedDesignSystemFontFamily.Pretendard.extraBold.font(size: size)
    }
    
    public static func extraLight(size: CGFloat) -> UIFont {
        return SharedDesignSystemFontFamily.Pretendard.extraLight.font(size: size)
    }
    
    public static func light(size: CGFloat) -> UIFont {
        return SharedDesignSystemFontFamily.Pretendard.light.font(size: size)
    }
    
    public static func medium(size: CGFloat) -> UIFont {
        return SharedDesignSystemFontFamily.Pretendard.medium.font(size: size)
    }
    
    public static func regular(size: CGFloat) -> UIFont {
        return SharedDesignSystemFontFamily.Pretendard.regular.font(size: size)
    }
    
    public static func semiBold(size: CGFloat) -> UIFont {
        return SharedDesignSystemFontFamily.Pretendard.semiBold.font(size: size)
    }

    public static func thin(size: CGFloat) -> UIFont {
        return SharedDesignSystemFontFamily.Pretendard.thin.font(size: size)
    }
}
