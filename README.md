# The Daily News

> A modern native iOS news application built with Swift and UIKit, designed to provide a personalized, immersive, and engaging news-reading experience.

## Overview

**The Daily News** is a native iOS news application focused on making news discovery and reading more engaging, personalized, and accessible.

The application goes beyond a traditional news feed by combining news discovery, personalized topics, article reading, saved content, reading history, reading statistics, reading goals, text-to-speech, article translation, annotation, and customizable themes into a single experience.

The project was built primarily with **UIKit** and **Swift**, while also exploring modern Apple technologies and frameworks available on recent versions of iOS.

The goal of the project was not only to build a functional news application, but also to explore how different Apple frameworks can work together inside a larger UIKit-based application.

---

## Project Goals

The main goals of The Daily News are:

* Build a complete native iOS application using Swift and UIKit.
* Create a polished and intuitive news-reading experience.
* Implement a scalable and maintainable application structure.
* Practice networking and dynamic data handling.
* Create reusable UI components.
* Implement local persistence for user-generated data.
* Build a centralized application-wide theme system.
* Explore modern Apple frameworks beyond traditional UIKit.
* Improve accessibility and user engagement through features such as Read Aloud and translation.
* Experiment with modern iOS visual and interaction patterns.
* Gain practical experience building a larger multi-feature iOS application.

---

# Key Features

## News Discovery

* Trending news
* Breaking news
* Latest news
* Topic-based discovery
* Personalized content
* Related stories
* Multiple news categories
* Surprise Me article discovery

## Article Experience

* Full article reading
* Page-based article navigation
* Save and unsave articles
* Reading history
* Read Aloud
* Article translation
* Article annotation
* Related stories

## Personalization

* Saved articles
* Reading history
* Reading statistics
* Daily reading goals
* Reading streaks
* Topic discovery
* Custom application themes

## Search

* Global article search
* Search across available news content
* Dynamic search results
* Direct navigation from search results to articles

## Accessibility & Engagement

* Text-to-speech article reading
* Translation into supported languages
* Reading goals
* Reading streaks
* Reading activity statistics

## Visual Experience

* Custom themes
* Centralized color system
* Centralized typography system
* Gradients
* Blur and material effects
* SF Symbols
* Custom cards and reusable components
* Modern iOS visual styling
* Animated Metal-based visual effects

---

# Technology Stack

| Technology                        | Purpose                          |
| --------------------------------- | -------------------------------- |
| **Swift**                         | Primary programming language     |
| **UIKit**                         | Application UI and interaction   |
| **SnapKit**                       | Programmatic Auto Layout         |
| **Firebase Authentication**       | User authentication              |
| **Google Sign-In**                | Google authentication            |
| **AVFoundation**                  | Text-to-speech / Read Aloud      |
| **Translation**                   | Article translation              |
| **PaperKit**                      | Article annotation               |
| **Metal / MetalKit**              | GPU-based visual effects         |
| **UserDefaults**                  | Lightweight local persistence    |
| **SF Symbols**                    | System icons                     |
| **Swift Charts**                  | Reading statistics visualization |
| **URLSession / Networking Layer** | API communication                |

---

# Architecture

The Daily News follows a UIKit-based architecture that separates UI responsibilities from data processing, networking, persistence, and application-level functionality.

The application uses a combination of **View Controllers, View Models, Models, Managers, and Services** to keep individual components focused on a specific responsibility.

## High-Level Data Flow

```text
                    News API
                       │
                       ▼
                 APIManager
                       │
                       ▼
                   ViewModel
                       │
                       ▼
                ViewController
                       │
                       ▼
              Custom Views / Cells
```

For user-specific functionality, the flow can also involve local managers and persistence:

```text
User Interaction
       │
       ▼
ViewController
       │
       ▼
Manager / Service
       │
       ▼
Local Persistence
       │
       ▼
UserDefaults
```

## View Controllers

View controllers are primarily responsible for:

* Managing the view hierarchy
* Configuring UI components
* Handling user interaction
* Responding to lifecycle events
* Coordinating navigation
* Communicating with view models and managers

## View Models

View models are responsible for preparing and transforming data before it reaches the UI.

They handle tasks such as:

* Processing API results
* Filtering articles
* Searching articles
* Preparing display data
* Managing view-specific state
* Communicating with networking services

This prevents view controllers from becoming responsible for both UI and data-processing logic.

## Managers

Managers encapsulate application-level functionality that may be used by multiple screens.

Examples include:

* `SavedManager`
* `ReadingHistoryManager`
* `ReadingGoalManager`
* `ReadingStreakManager`
* `ReadAloudManager`
* `ThemeManager`

Managers provide a centralized location for functionality that should not be duplicated across view controllers.

## Services

Services are responsible for specialized functionality.

Examples include:

* Networking
* Translation
* Authentication
* Speech synthesis

This separation allows framework-specific functionality to remain independent from the application's UI.

---

# Authentication & Onboarding

The application begins with an onboarding experience designed to introduce users to the application before they enter the main news experience.

The authentication flow provides users with options to create an account or log in.

The authentication system integrates:

* Firebase Authentication
* Google Sign-In

The general flow is:

```text
Splash Screen
      ↓
Onboarding
      ↓
Authentication
      ↓
Home
```

Authentication-related logic is kept separate from the main news experience so that the application can independently manage the user's authentication state.

---

# Home

The Home screen acts as the primary entry point into The Daily News.

It combines multiple types of news content into a single scrollable experience.

The main sections include:

* Trending News
* Breaking News
* Latest News
* Additional personalized/discovery content

## Trending News

The Trending News section provides a visually prominent presentation of important or popular stories.

A page-based interface is used to give major stories more visual emphasis than a conventional list.

## Breaking News

Breaking News is presented as a horizontally scrolling collection of stories.

The implementation uses a `UICollectionView` embedded inside a reusable table-view cell.

This allows the Home screen to combine vertical and horizontal content within a single feed.

## Latest News

Latest News provides the primary chronological news feed.

Each article provides information such as:

* Topic
* Headline
* Article image
* Publication information
* Reading-related metadata

The section is designed for quick scanning while maintaining a consistent visual hierarchy.

## Surprise Me

The **Surprise Me** feature provides an alternative way to discover content.

Instead of requiring the user to select a specific topic or search for an article, the feature selects an available article and takes the user directly into the article-reading experience.

This encourages exploration and makes the application feel less dependent on a strictly chronological feed.

---

# Explore

The Explore screen is designed specifically for content discovery.

Rather than presenting articles only through a chronological feed, Explore organizes content around topics and categories.

Examples of discoverable topics include:

* Technology
* World
* Entertainment
* Anime
* Science
* Business
* Sports

The topic-based approach allows users to explore areas outside their normal news feed and discover content based on their interests.

The Explore experience also experiments with dynamic layouts and modern visual effects to make content discovery feel more interactive.

---

# Search

The Search screen allows users to search through available news content.

Search is implemented using Apple's `UISearchController`.

The search process is structured around the application's view model:

```text
User enters search query
          ↓
Search ViewModel
          ↓
Filter available articles
          ↓
Update search results
          ↓
Reload UI
          ↓
User selects article
          ↓
Article Reader
```

The search experience is designed to provide immediate feedback while keeping search-specific logic separate from the view controller.

---

# Article Reading Experience

The article reader is one of the central components of The Daily News.

Instead of treating an article as a simple detail screen, the application provides a dedicated reading experience with additional tools and functionality.

The article experience includes:

* Full article content
* Article imagery
* Article metadata
* Page-based navigation
* Related stories
* Save functionality
* Reading history
* Read Aloud
* Translation
* Annotation

## Page-Based Article Navigation

`UIPageViewController` is used to create a page-based article experience.

This allows users to move between articles horizontally while maintaining the vertical reading experience within each article.

The article architecture therefore combines:

```text
Horizontal Navigation
        +
Vertical Article Reading
```

This required careful coordination between the page view controller and the article's internal scrolling content.

---

# Saved Articles

Users can save articles that they want to return to later.

The saved-article system provides:

* Save
* Unsave
* Saved article list
* Persistent storage
* Automatic UI updates

Saved articles are stored locally so that the user's saved content remains available after the application is relaunched.

A centralized `SavedManager` handles this functionality.

Changes to saved articles are propagated through `NotificationCenter`, allowing multiple screens to remain synchronized.

---

# Reading History

The Daily News maintains a record of articles that users have read.

Reading history serves several purposes:

* Keeping track of previously read content
* Supporting reading statistics
* Supporting reading activity analysis
* Providing a foundation for future personalization

The reading history is managed through a dedicated `ReadingHistoryManager`.

The manager is responsible for storing and retrieving reading-history data independently of the UI.

---

# Reading Statistics

The Reading Statistics section provides users with an overview of their reading activity.

The statistics experience focuses on turning raw reading activity into meaningful feedback.

Information can include:

* Total articles read
* Total reading time
* Daily reading activity
* Weekly reading activity
* Reading goal progress
* Reading streak

## Reading Time

Reading time is accumulated from the user's reading sessions.

The application combines reading activity across the relevant days to calculate broader statistics such as weekly reading time.

The statistics view presents this information visually so that users can quickly understand their reading habits.

## Weekly Statistics

Weekly statistics organize reading activity chronologically across the days of the week.

The chart and supporting statistics are designed to make comparisons between days easy to understand.

---

# Reading Goals

Users can define a daily reading goal.

For example:

```text
Daily Reading Goal
30 minutes
```

The `ReadingGoalManager` is responsible for managing:

* Daily reading goal
* Today's reading time
* Daily reset
* Reading-time updates
* Goal persistence

The goal is stored locally so that it remains available between application launches.

---

# Reading Streaks

The reading streak system encourages consistent reading.

A streak represents consecutive days on which the user has met the application's criteria for reading activity.

`ReadingStreakManager` handles the streak logic and determines whether the user's current reading activity continues an existing streak or begins a new one.

The system also takes date changes into account so that reading activity is evaluated against the correct day.

---

# Read Aloud

The Daily News includes a Read Aloud feature that allows users to listen to article content instead of reading it manually.

The feature uses Apple's speech synthesis APIs through `AVFoundation`.

The core implementation is based on:

```swift
AVSpeechSynthesizer
```

## Read Aloud Flow

```text
Article Text
     ↓
ReadAloudManager
     ↓
AVSpeechSynthesizer
     ↓
Speech Output
     ↓
Progress Tracking
     ↓
Read Aloud Player
```

## Controls

The Read Aloud player supports:

* Play
* Pause
* Resume
* Stop
* Reading progress

A dedicated player interface provides persistent controls without requiring the user to leave the article-reading experience.

The feature also improves accessibility by providing an alternative way to consume written news content.

---

# Article Translation

The Daily News integrates Apple's Translation framework to provide translated versions of article content.

The translation system is designed as a separate service rather than placing translation logic directly inside the article view controller.

This keeps the article UI focused on presentation while the translation service handles translation-specific functionality.

Supported target languages can include:

* French
* Spanish
* German
* Portuguese
* Other languages supported by Apple's Translation framework

The translation architecture also makes it easier to expand the list of supported languages in the future.

---

# Article Annotation

The Daily News explores Apple's **PaperKit** framework to provide an annotation experience within the article-reading workflow.

PaperKit provides tools that allow users to interact with content using digital markup.

Potential annotation interactions include:

* Drawing
* Highlighting
* Marking important information
* Free-form annotation

The feature demonstrates how a modern Apple framework can be integrated into an existing UIKit application without replacing the application's primary UI architecture.

---

# Theme System

The Daily News includes a centralized theme system that allows the application's appearance to be customized.

Rather than hard-coding colors and typography throughout individual screens, visual properties are defined through reusable theme objects.

## Theme Architecture

```text
ThemeRepository
       ↓
ThemeModel
       ↓
ThemeManager
       ↓
┌───────────────┬─────────────────┐
│ ThemeColors   │ ThemeTypography │
└───────────────┴─────────────────┘
       ↓
Application UI
```

## ThemeManager

`ThemeManager` acts as the central source of truth for the active theme.

It is responsible for:

* Managing the current theme
* Applying themes
* Persisting theme selection
* Broadcasting theme changes

When a theme changes, `NotificationCenter` can notify active screens so that they can update their appearance.

## Theme Components

A theme can define:

* Background colors
* Primary colors
* Secondary colors
* Accent colors
* Text colors
* Typography
* Other visual properties

The architecture allows new themes to be introduced without rewriting the UI of individual screens.

---

# Metal Integration

Metal is used in The Daily News to experiment with GPU-based rendering and custom visual effects.

The Explore experience uses Metal-based rendering to create an animated visual environment that would be more difficult to achieve using only standard UIKit components.

Metal provides:

* GPU-accelerated rendering
* Custom shaders
* Dynamic visual effects
* Smooth animation

The project demonstrates how Metal can coexist with UIKit, with UIKit continuing to handle the primary application interface while Metal handles specialized visual rendering.

---

# Networking

The Daily News uses a centralized networking layer to communicate with external news APIs.

The networking architecture follows this general flow:

```text
ViewController
      ↓
ViewModel
      ↓
APIManager
      ↓
HTTP Request
      ↓
News API
      ↓
JSON Response
      ↓
Model
      ↓
ViewModel
      ↓
UI
```

## APIManager

`APIManager` provides a centralized interface for API communication.

Its responsibilities include:

* Creating network requests
* Communicating with the API
* Receiving responses
* Handling errors
* Decoding response data
* Returning application models

Centralizing networking prevents individual view controllers from directly managing API requests.

---

# Data Persistence

The Daily News uses `UserDefaults` for lightweight local persistence.

The persistence layer is used for user-specific information that does not require a full database.

Examples include:

```text
UserDefaults
│
├── Saved Articles
├── Reading History
├── Reading Goal
├── Reading Time
├── Reading Streak Information
├── Selected Theme
└── User Preferences
```

Articles can be encoded before storage and decoded when retrieved.

```text
Article
   ↓
JSONEncoder
   ↓
Data
   ↓
UserDefaults
```

Retrieval follows the reverse process:

```text
UserDefaults
   ↓
Data
   ↓
JSONDecoder
   ↓
Article
```

For future versions of the application, a dedicated persistence framework such as SwiftData or Core Data could be considered for larger and more relational datasets.

---

# UIKit Techniques

The Daily News makes extensive use of UIKit and its reusable UI components.

## UITableView

Used for vertically structured content including:

* Home feed
* Latest News
* Search results
* Reading statistics
* Other structured sections

## UICollectionView

Used for horizontally scrolling and dynamically structured content such as:

* Breaking News
* Topic sections
* Discovery content

## Nested Collection Views

Several sections combine `UITableView` and `UICollectionView`.

For example:

```text
UITableView
│
├── Trending
│
├── Breaking News
│       └── UICollectionView
│
├── Latest News
│
└── Additional Sections
```

This allows the application to create complex feeds while keeping each component reusable.

## UIPageViewController

Used to provide horizontal article navigation.

## UISearchController

Used to provide native search functionality.

## Custom Cells

Reusable cells are used throughout the application to maintain consistency and reduce duplicated UI code.

## SnapKit

SnapKit is used for programmatic Auto Layout.

This makes constraints more concise and readable than manually constructing large numbers of `NSLayoutConstraint` objects.

## UIVisualEffectView

Blur and material effects are used to create depth and modern system-style interfaces.

## SF Symbols

SF Symbols are used for system-consistent iconography throughout the application.

---

# Modern iOS & Apple Technologies

One of the major goals of The Daily News was to explore Apple's modern development ecosystem rather than limiting the application to traditional UIKit functionality.

Technologies explored in the project include:

### PaperKit

Used for article annotation and markup interactions.

### Translation

Used to provide article translation into supported languages.

### Metal

Used for custom GPU-powered visual effects.

### Swift Charts

Used for presenting reading statistics and activity visually.

### Modern UIKit

The application also explores modern UIKit styling and interaction patterns, including:

* Material effects
* Modern system components
* SF Symbols
* Modern navigation
* Dynamic visual styling
* Liquid Glass-compatible design patterns

---

# Technical Challenges & Solutions

Building The Daily News involved several technical challenges.

## Nested Scrolling

### Challenge

The Home screen contains vertically scrolling content as well as horizontally scrolling sections.

### Solution

Horizontal `UICollectionView` instances were embedded inside reusable `UITableViewCell` subclasses.

This allowed each section to maintain its own scrolling behavior while remaining part of the main feed.

---

## Article Paging and Vertical Scrolling

### Challenge

The article reader needed to support horizontal article navigation while also allowing the user to vertically scroll through the current article.

### Solution

`UIPageViewController` was combined with vertically scrollable article content.

The implementation required careful coordination between the page controller and the internal article scroll view.

---

## Reading-Time Tracking

### Challenge

Reading time needs to be accumulated across sessions while still respecting daily boundaries.

### Solution

A dedicated reading-goal/reading-time manager keeps track of the current day's reading duration and resets daily values when a new calendar day begins.

This information can then be consumed by the statistics and goal interfaces.

---

## Theme Synchronization

### Challenge

Changing the application theme should update multiple screens without tightly coupling every view controller to the theme-selection screen.

### Solution

A centralized `ThemeManager` maintains the active theme and broadcasts changes through `NotificationCenter`.

This allows interested screens to react to theme changes independently.

---

## Persistent User Data

### Challenge

Saved articles, reading history, goals, and preferences need to remain available after the application is relaunched.

### Solution

Lightweight user data is encoded and persisted through `UserDefaults`, with dedicated managers responsible for each type of stored information.

---

## Reusable UI Components

### Challenge

The application contains many different news sections that share similar UI patterns.

### Solution

Reusable custom cells and views were created for common content types.

This improves consistency while reducing duplicated layout and configuration code.

---

# Accessibility & User Experience

Accessibility and usability are important parts of The Daily News.

## Read Aloud

Text-to-speech provides an alternative way to consume articles and can be useful when users cannot comfortably read the screen.

## Translation

Translation makes news content accessible to users who prefer reading in another language.

## Visual Hierarchy

The UI uses:

* Typography hierarchy
* Spacing
* Image prominence
* Consistent cards
* Clear metadata
* Familiar system icons

to make articles easy to scan.

## Themes

Multiple themes allow users to choose a visual appearance that suits their preference.

---

# Security & Configuration

Sensitive information such as API keys, authentication credentials, and private configuration values should not be committed to source control.

The project should keep credentials separate from publicly visible source code.

Sensitive configuration may include:

* API keys
* Firebase configuration
* Google Sign-In credentials
* Private service credentials

Before running the project, the required configuration must be provided locally.

Actual credentials should never be placed inside this README.

---

# Installation

## Requirements

* macOS
* Xcode 26 or later
* iOS 26 or later
* Swift
* Required API credentials
* Firebase configuration if authentication is enabled

## Clone the Repository

```bash
git clone <repository-url>
cd NewsCom
```

Open the project in Xcode and configure the required services and credentials.

---

# Running the Application

1. Clone the repository.
2. Open the Xcode project.
3. Configure the required API keys.
4. Add the required Firebase configuration.
5. Configure Google Sign-In if required.
6. Select an iOS Simulator or physical device.
7. Build and run the application.

---

# Dependencies

## SnapKit

Used for programmatic Auto Layout and constraint management.

## Firebase Authentication

Used for account authentication and user identity management.

## Google Sign-In

Used to provide Google-based authentication.

Apple frameworks are used wherever possible to keep the application native to the iOS ecosystem.

---

# Future Improvements

Potential future improvements include:

* More advanced news recommendations
* More sophisticated personalization
* Improved offline support
* Migration to SwiftData or Core Data for larger datasets
* Push notifications
* Breaking-news notifications
* Home Screen widgets
* Live Activities
* More advanced reading analytics
* Persistent annotation storage
* Additional translation languages
* More sophisticated topic personalization
* Improved image and article caching
* Background content updates
* More advanced accessibility support

---

# What I Learned

Building The Daily News provided hands-on experience with a wide range of iOS development concepts.

The project helped strengthen my understanding of:

### UIKit

* `UIViewController`
* `UITableView`
* `UICollectionView`
* `UIPageViewController`
* `UISearchController`
* Custom reusable cells
* Auto Layout
* Navigation
* Gestures
* Animations

### Architecture

The project demonstrated the importance of separating UI responsibilities from networking, persistence, and application-level logic.

### Networking

I gained practical experience with:

* API requests
* JSON decoding
* Data models
* Error handling
* Centralized networking

### Persistence

The project provided experience working with lightweight local persistence and understanding when a dedicated database solution would be more appropriate.

### Apple's Frameworks

The Daily News provided an opportunity to explore frameworks beyond traditional UIKit, including:

* AVFoundation
* Translation
* PaperKit
* Metal
* Swift Charts

### User Experience

The project reinforced the importance of designing features around real user workflows.

Features such as Saved Articles, Reading History, Reading Goals, Read Aloud, Translation, and personalized discovery are intended to make the application more useful rather than simply increasing the number of features.

---

# Credits

Developed by **Anjali Sharma**.

**The Daily News** is an iOS development project focused on building a modern native news application while exploring UIKit, Swift, and Apple's modern frameworks.

---

# License

This project is currently intended for educational and demonstration purposes.

If the project is later distributed publicly, an appropriate open-source license can be added through a dedicated `LICENSE` file.

