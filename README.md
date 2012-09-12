# DBKit #
DBKit is a collection of code that I find useful in many of the applications that I write. DBKit uses ARC and is compatible with iOS 5.0 or greater.

# Adding DBKit with Cocoapods (the easy way) #
Simply add the following to your Podfile:

  - `pod "DBKit", :git => "https://github.com/DavidBarry/DBKit.git"`

# Manually adding DBKit to your project (the not so easy way) #
## Add DBKit to your project ##
  - Download the code and place it in Vendor/DBKit (relative to your project root directory)
    -  You can optionally add the repo as a git submodule: `git submodule add git://github.com/DavidBarry/DBKit.git Vendor/DBKit`
  - Drag the DBKit.xcodeproj file into your Xcode project
  - Select your Xcode project in the sidebar and then select the target you would like to add DBKit to and select the *Build Phases* tab.
  - Add `DBKit` and `DBKitResources` to the *Target Dependencies* phase.
  - Add `libDBKit.a` and `QuartzCore.framework` to the *Link Binary With Libraries* phase.
  - In the sidebar expand the DBKit project and drag `DBKitResources.bundle` from the Products folder into the *Copy Bundle Resources* phase.
  - Select the *Build Settings Tab*
  - Add the following to *Header Search Paths* (include quotation marks)
    - "$(TARGET_BUILD_DIR)/usr/local/lib/include"
    - "$(OBJROOT)/UninstalledProducts/include"
  - Add  `-ObjC` to *Other Linker Flags*

## Add DBCoreData to your project ##
DBCoreData is a separate staic library that can optionally be included in projects that use Core Data. To integrate DBCoreData follow the same steps as above with the following additions:
  - Add `DBCoreData` to the *Target Dependencies* phase.
  - Add `libDBCoreData.a` and `CoreData.framework` to the *Link Binary With Libraries* phase.

