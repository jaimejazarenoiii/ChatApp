# ChatApp

A Chat app using firestore as storage

## Requirements

  * >= iOS 13
  * >= Xcode 11

## Setup

There's a setup script in the repo named `project_setup.sh`

To run script just simply enter this command from the root directory:
```
./project_setup.sh
```

This will:
  * Check if **ruby** is installed
  * Check if **brew** is installed
  * Check if **bundler** is installed and install it if not
  * Install **Gems**
  * Install **Cocoapods**
  * Copy secrets from another repo
  * Build **Xcode**

## Architecture

It's a swift project using MVVM Framework together with ReactiveCocoa /
ReactiveSwift
