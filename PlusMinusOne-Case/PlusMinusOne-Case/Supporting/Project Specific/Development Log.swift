//
//  Development Log.swift
//  PlusMinusOne-Case
//
//  Created by Sefa İbiş on 2.11.2023.
//

// - Decisions & Developments Log

// +-1 ~ Date: 2.11

// • Application Architecture: MVVM
// • Fully programmatic UI construction. Considered this decision for the future-scope so that storyboard conflicts will not be an issue.
// • Preparation of some mock-data will be handy to notice some imperceived UI problems.
// • Detail Page requires a branching so having a collectionView or tableView makes sense.
// • Updated XCode for the requirement of iOS 16-17 compatibility.

// +-1 ~ Date: 3.11

// • Adapted MVVM architectural design pattern to adhere SOLID principles and make the code testable.
// • First of wrote the required MVVM boilerplate. Started clean and continued clean.
// • Prefered concise and simple commenting. Used descriptive namings for variables and methods.
// • Delegation is done with protocols also used as communication pattern. Views and ViewModels have contracts for future-expansion.
// • Programatically constructed the UI with auto-layout. Used stackViews extensively.
// • Added collectionView for future-purpose. Since this is a product showcase related app decided it will be convinient to have. Also, added "columnPreference" variable for future-purpose to make the code readily available for gridLayout.
// • Made a custom cell for the collectionView also did the detail routing part.

// +-1 ~ Date: 4.11

// • Included social.json and product.json to the project. Populated them to 30 products.
// • Developed a DecoderService to read both of the jsons. Is generic for future-use.
// • Added DTO's to objectify the jsons.
// • Used type-aliases for clean code purposes.
// • Completed data preparation to work with data during UI construction.
// • Data is alive in collectionView customCells and detail page.

// +-1 ~ Date: 5.11

// • Decided to do the visual layout of the UI's before feeding data into them.
// • To do proper visual layouting did color coding on each view. Cleared the coloration afterwards.
// • Did these for custom cell layouting and detail page layouting.
// • Added scrollView to the detail page for future-use purposes. Generally detail pages are scrolled down.
// • Did not want to use lottie for the countdown. Decided to make the countdown be adapted to the view it resides in for future-use.
// • Decided needed packages: kingfisher, cosmos

// +-1 ~ Date: 6.11

// • Constructed detail page with UI variables and populated with corresponding data
// • Constructed productCell with UI variables and populated with corresponding data
// • Finalized UI of the app
// • Kingfisher option to cache images was included for performance
// • Thought to resize images to gain performance but did not deal with it
// • Added a enum to hold the strings
// • Finalized UI of the app

// +-1 ~ Date: 7.11

// • Intended to modify json file to simulate the social update, aborted after facing file-access failures
// • Did a workaround to simulate social update, upon countdown end the code reads the unchanged json file with id and passes that specific socialFeed to ViewModel as latestSocialUpdate, view accesses that variable, then in view I manually randomized social values.
// • Left the code (decodeModifyEncodeSave) in DecoderService intentionally in-case I decide to make it work.
// • Included state handling for the socials.
// • Intentionally made the code to showcase the error use-case also.
// • Completed the project. Continuing on for testing and refactoring.

// +-1 ~ Date: 8.11

// • Unit testing completed. ViewModel's productDetail and productGallery all contracted methods passed.
// • UI testing passes. Covered the tap collectionView to navigate to detail page case only.
// • Will refactor or check: namings, left todo's, left fixme's, empty methods, some minor improvements.

// - Considered to do but did not
// • For performant UI can resize or scaleDown for custom cell
// • CheckInternet connectivity


