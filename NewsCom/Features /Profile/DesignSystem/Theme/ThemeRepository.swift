//
//  ThemeRepo.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 02/06/26.
//

import UIKit


enum ThemeRepository {}


extension ThemeRepository {

    static let modern = ThemeModel(

        id: "modern",

        name: "Default", subtitle: "Default Theme",

        colors: ThemeColors(
            
            background: UIColor(named: "defaultBackground") ?? .white,

            surface: UIColor(named: "defaultSurface") ?? .white,

            primary: UIColor(named: "defaultPrimary") ?? .white,

            secondary: UIColor(named: "defaultSecondary") ?? .white,

            textColor: UIColor(named: "defaultText") ?? .white,

            outline: UIColor(named: "defaultOutline") ?? .white
        ),

        typography: ThemeTypography(
            headline: UIFont(name: "Manrope-Bold", size: 24) ?? .boldSystemFont(ofSize: 24),
            body: UIFont(name: "Manrope-Regular", size: 16) ?? .boldSystemFont(ofSize: 16),
            label: UIFont(name: "Manrope-Medium", size: 12) ?? .boldSystemFont(ofSize: 12)
        ),

        spacing: ThemeSpacing(
            gutter: 16,
            sectionGap: 24,
            margin: 20
        ),

        radius: ThemeRadius(
            card: 8,
            button: 8
        )
    )
        static let autumn = ThemeModel(

            id: "autumn",

            name: "Autumn", subtitle: "Warm tones",

            colors: ThemeColors(

                background: UIColor(named: "autumnBackground") ?? .white,

                surface: UIColor(named: "autumnSurface") ?? .white,

                primary: UIColor(named: "autumnPrimary") ?? .white,

                secondary: UIColor(named: "autumnSecondary") ?? .white,

                textColor: UIColor(named: "autumnText") ?? .white,

                outline: UIColor(named: "autumnOutline") ?? .white
            ),

            typography: ThemeTypography(

                headline: UIFont(name: "PlayfairDisplay-SemiBold", size: 32) ?? .boldSystemFont(ofSize: 32),
                body: UIFont(name: "PlusJakartaSans-Regular", size: 16) ?? .boldSystemFont(ofSize: 16),

                label: UIFont(
                    name: "PlusJakartaSans-SemiBold",
                    size: 14
                ) ?? .boldSystemFont(ofSize: 14)
            ),

            spacing: ThemeSpacing(

                gutter: 24,

                sectionGap: 120,

                margin: 16
            ),

            radius: ThemeRadius(

                card: 8,

                button: 8
            )
        )
    
    static let fairytale = ThemeModel(

            id: "fairytale",

            name: "Fairytale", subtitle: "Enchanted Royal Aesthetic",

            colors: ThemeColors(

                background: UIColor(named: "fairyTaleBackground") ?? .white,

                surface: UIColor(named: "fairyTaleSurface") ?? .black,

                primary: UIColor(named: "fairyTalePrimary") ?? .green,

                secondary: UIColor(named: "fairyTaleSecondary") ?? .blue,

                textColor: UIColor(named: "fairyTaleText") ?? .purple,

                outline: UIColor(named: "fairyTaleOutline") ?? .yellow
            ),

            typography: ThemeTypography(

                headline: UIFont(
                    name: "PlayfairDisplay-SemiBold",
                    size: 24
                ) ?? .boldSystemFont(ofSize: 24),

                body: UIFont(
                    name: "PlusJakartaSans-Regular",
                    size: 16
                ) ?? .boldSystemFont(ofSize: 16),

                label: UIFont(
                    name: "PlusJakartaSans-SemiBold",
                    size: 14
                ) ?? .boldSystemFont(ofSize: 14)
            ),

            spacing: ThemeSpacing(

                gutter: 16,

                sectionGap: 64,

                margin: 24
            ),

            radius: ThemeRadius(

                card: 16,
                
                button: 999
            )
        )
    
//    static let arctic = ThemeModel(
//
//        id: "arctic",
//
//        name: "Arctic", subtitle: "Cool tone",
//
//        colors: ThemeColors(
//            
//            background: UIColor(named: "arcticBackground") ?? .white,
//
//            surface: UIColor(named: "arcticSurface") ?? .white,
//
//            primary: UIColor(named: "arcticPrimary") ?? .white,
//
//            secondary: UIColor(named: "arcticSecondary") ?? .white,
//
//            textColor: UIColor(named: "arcticText") ?? .white,
//
//            outline: UIColor(named: "arcticOutline") ?? .white
//        ),
//
//        typography: ThemeTypography(
//            headline: UIFont(name: "Manrope-Bold", size: 24) ?? .boldSystemFont(ofSize: 24),
//            body: UIFont(name: "Manrope-Regular", size: 16) ?? .boldSystemFont(ofSize: 16),
//            label: UIFont(name: "Manrope-Medium", size: 12) ?? .boldSystemFont(ofSize: 12)
//        ),
//
//        spacing: ThemeSpacing(
//            gutter: 16,
//            sectionGap: 24,
//            margin: 20
//        ),
//
//        radius: ThemeRadius(
//            card: 8,
//            button: 8
//        )
//    )
//    static let aurora = ThemeModel(
//
//        id: "aurora",
//
//        name: "Aurora", subtitle: "Cool tone",
//
//        colors: ThemeColors(
//            
//            background: UIColor(named: "auroraBackground") ?? .white,
//
//            surface: UIColor(named: "auroraSurface") ?? .white,
//
//            primary: UIColor(named: "auroraPrimary") ?? .white,
//
//            secondary: UIColor(named: "auroraSecondary") ?? .white,
//
//            textColor: UIColor(named: "auroraText") ?? .white,
//
//            outline: UIColor(named: "auroraOutline") ?? .white
//        ),
//
//        typography: ThemeTypography(
//            headline: UIFont(name: "Manrope-Bold", size: 24) ?? .boldSystemFont(ofSize: 24),
//            body: UIFont(name: "Manrope-Regular", size: 16) ?? .boldSystemFont(ofSize: 16),
//            label: UIFont(name: "Manrope-Medium", size: 12) ?? .boldSystemFont(ofSize: 12)
//        ),
//
//        spacing: ThemeSpacing(
//            gutter: 16,
//            sectionGap: 24,
//            margin: 20
//        ),
//
//        radius: ThemeRadius(
//            card: 8,
//            button: 8
//        )
//    )
//    static let forest = ThemeModel(
//
//        id: "forest",
//
//        name: "Forest", subtitle: "Nature Vibes",
//
//        colors: ThemeColors(
//            
//            background: UIColor(named: "forestBackground") ?? .white,
//
//            surface: UIColor(named: "forestSurface") ?? .white,
//
//            primary: UIColor(named: "forestPrimary") ?? .white,
//
//            secondary: UIColor(named: "forestSecondary") ?? .white,
//
//            textColor: UIColor(named: "forestText") ?? .white,
//
//            outline: UIColor(named: "forestOutline") ?? .white
//        ),
//
//        typography: ThemeTypography(
//            headline: UIFont(name: "Manrope-Bold", size: 24) ?? .boldSystemFont(ofSize: 24),
//            body: UIFont(name: "Manrope-Regular", size: 16) ?? .boldSystemFont(ofSize: 16),
//            label: UIFont(name: "Manrope-Medium", size: 12) ?? .boldSystemFont(ofSize: 12)
//        ),
//
//        spacing: ThemeSpacing(
//            gutter: 16,
//            sectionGap: 24,
//            margin: 20
//        ),
//
//        radius: ThemeRadius(
//            card: 8,
//            button: 8
//        )
//    )
    static let midnight = ThemeModel(

        id: "midnight",

        name: "Midnight", subtitle: "Cool Vibes",

        colors: ThemeColors(
            
            background: UIColor(named: "midnightBackground") ?? .white,

            surface: UIColor(named: "midnightSurface") ?? .white,

            primary: UIColor(named: "midnightPrimary") ?? .white,

            secondary: UIColor(named: "midnightSecondary") ?? .white,

            textColor: UIColor(named: "midnightText") ?? .white,

            outline: UIColor(named: "midnightOutline") ?? .white
        ),

        typography: ThemeTypography(
            headline: UIFont(name: "Manrope-Bold", size: 24) ?? .boldSystemFont(ofSize: 24),
            body: UIFont(name: "Manrope-Regular", size: 16) ?? .boldSystemFont(ofSize: 16),
            label: UIFont(name: "Manrope-Medium", size: 12) ?? .boldSystemFont(ofSize: 12)
        ),

        spacing: ThemeSpacing(
            gutter: 16,
            sectionGap: 24,
            margin: 20
        ),

        radius: ThemeRadius(
            card: 8,
            button: 8
        )
    )
    static let sakura = ThemeModel(

        id: "sakura",

        name: "Sakura", subtitle: "Hello kitty Vibes",

        colors: ThemeColors(
            
            background: UIColor(named: "sakuraBackground") ?? .white,

            surface: UIColor(named: "sakuraSurface") ?? .white,

            primary: UIColor(named: "sakuraPrimary") ?? .white,

            secondary: UIColor(named: "sakuraSecondary") ?? .white,

            textColor: UIColor(named: "sakuraText") ?? .white,

            outline: UIColor(named: "sakuraOutline") ?? .white
        ),

        typography: ThemeTypography(
            headline: UIFont(name: "Manrope-Bold", size: 24) ?? .boldSystemFont(ofSize: 24),
            body: UIFont(name: "Manrope-Regular", size: 16) ?? .boldSystemFont(ofSize: 16),
            label: UIFont(name: "Manrope-Medium", size: 12) ?? .boldSystemFont(ofSize: 12)
        ),

        spacing: ThemeSpacing(
            gutter: 16,
            sectionGap: 24,
            margin: 20
        ),

        radius: ThemeRadius(
            card: 8,
            button: 8
        )
    )
    
    static let sunset = ThemeModel(

        id: "sunset",

        name: "Sunset", subtitle: "Sunset Vibes",

        colors: ThemeColors(
            
            background: UIColor(named: "sunsetBackground") ?? .white,

            surface: UIColor(named: "sunsetSurface") ?? .white,

            primary: UIColor(named: "sunsetPrimary") ?? .white,

            secondary: UIColor(named: "sunsetSecondary") ?? .white,

            textColor: UIColor(named: "sunsetText") ?? .white,

            outline: UIColor(named: "sunsetOutline") ?? .white
        ),

        typography: ThemeTypography(
            headline: UIFont(name: "Manrope-Bold", size: 24) ?? .boldSystemFont(ofSize: 24),
            body: UIFont(name: "Manrope-Regular", size: 16) ?? .boldSystemFont(ofSize: 16),
            label: UIFont(name: "Manrope-Medium", size: 12) ?? .boldSystemFont(ofSize: 12)
        ),

        spacing: ThemeSpacing(
            gutter: 16,
            sectionGap: 24,
            margin: 20
        ),

        radius: ThemeRadius(
            card: 8,
            button: 8
        )
    )
    
    static let allThemes = [modern, autumn, fairytale, sakura]
    
}


