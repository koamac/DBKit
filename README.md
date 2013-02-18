# DBKit #
DBKit is a collection of code that I find useful in many of the applications that I write. DBKit uses ARC and is compatible with iOS 5.0 or greater(though it must be built with the iOS6 SDK).

# Adding DBKit with Cocoapods #
Simply add the following to your Podfile:

  - `pod "DBKit"`

Alternatively, if you only want DBKit without DBCoreData, or if you want just DBCoreData you can use the following subspecs:
  - `pod "DBKit/DBKit"`
  - `pod "DBKit/DBCoreData"`

# Manually adding DBKit to your project  #
## Add DBKit to your project ##
  - Copy the `DBKit` and `DBKitResources` folders into your project
  
## Add DBCoreData to your project ##
DBCoreData is a separate staic library that can optionally be included in projects that use Core Data.

  - Copy the `DBCoreData` folder into your project.

