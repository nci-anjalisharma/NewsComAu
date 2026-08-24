//
//  InterestsPreferenceViewModel.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 09/07/26.
//

import UIKit

final class InterestsPreferenceViewModel {

    var topics: [InterestItem] = [
        InterestItem(icon: UIImage(systemName: "bolt.fill"), title: "Trending News", isEnabled: true),
        InterestItem(icon: UIImage(systemName: "bell.badge.fill"), title: "Breaking News", isEnabled: true),
        InterestItem(icon: UIImage(systemName: "newspaper.fill"), title: "Latest News", isEnabled: false),
    ]

    var notifications: [NotificationItem] = [
        NotificationItem(
            title: "Breaking News Alerts",
            subtitle: "Instant updates on world events",
            isEnabled: true
        ),
        NotificationItem(
            title: "Daily Briefing",
            subtitle: "Morning summary of top stories",
            isEnabled: true
        )
    ]

    var contentSettings: [ContentSettingItem] = [
        ContentSettingItem(
            title: "Article Length Preference",
            value: "Medium"
        )
    ]
    
    let dataManagement: [DataManagementOption] = [
            DataManagementOption(
                title: "Clear Reading History",
                subtitle: "Delete your recent activity and reset recommendations."
            ),
            DataManagementOption(
                title: "Clear Saved Articles",
                subtitle: "Remove all articles from your saved library."
            )
        ]
}
