//
//  DarkTheme.swift
//  MedUp
//
//  Created by Hrant on 09.05.21.
//

public final class DarkTheme: ITheme {
    public var isBlurred: Bool = true
    public var isDark: Bool = true

    public static var current: ITheme = DarkTheme()

    public var colors: IColors = DarkColors()
    public var fonts: IFonts = DefaultFont()

    private init() {}
}
