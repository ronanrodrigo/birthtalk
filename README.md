<h1>
<img src="https://raw.githubusercontent.com/ronanrodrigo/birthtalk/master/Birthtalk/Base/AppIcon.png" height=25/>
Birthtalk
</h1>
[![Build Status](https://travis-ci.org/ronanrodrigo/birthtalk.svg?branch=master)](https://travis-ci.org/ronanrodrigo/birthtalk) [![Codecov](https://codecov.io/github/ronanrodrigo/birthtalk/coverage.svg?precision=2)](https://codecov.io/gh/ronanrodrigo/birthtalk) [![Code Climate](https://codeclimate.com/github/ronanrodrigo/birthtalk/badges/gpa.svg)](https://codeclimate.com/github/ronanrodrigo/birthtalk)

-------
<p align="center">
  <a href="#motivation">Motivation</a> •
  <a href="#installation">Instalation</a> •
  <a href="#tests">Tests</a>
</p>
-------

## Motivation
In a world where delivery is almost more important than the good code, I decided to create my product based on in a craft work. Following best practices in Software Development and using the least possible third party libraries. This project will be documented in a series of blog posts and the main topics will be TDD, Clean Architecture, SOLID principles and views construct by Code.

This Application will automatically create chat groups where people talk with others that have common things based on their births. It will be possible to meet who born at same day/month/year, or same day/month, or same day/month/year/city, or same zodiac sign and among other combinations.

## Posts
- [First post: Authentication rules in a handcrafted iOS application with TDD](https://medium.com/cocoaacademymag/authentication-rules-in-a-handcrafted-ios-application-with-tdd-8db5396ebac6#.7kq4cc2x5)

## Installation
This application does not have directly dependencies and libraries. But at development environment I use some tools like **[Fastlane](http://fastlane.tools)**, **[Danger](http://danger.systems)**, **[Danger Slather](https://github.com/SlatherOrg/slather)** and **[Swift Lint](https://github.com/realm/SwiftLint)**. The first three tools are  installed with ruby bundler gem and the Swift Lint is installed with brew.

```shell
bundle install
brew install swiftlint
```

### Note
Temporally it will use Firebase because I am not in Apple Developer Program Membership. But shortly it will be replaced by CloudKit. Now it is necessary to install Firebase

```shell
pod install
```

## Tests
This application use native tests library XCTest. And it is possible to run that with fastlane command.

```shell
bundle exec fastlane test
```
