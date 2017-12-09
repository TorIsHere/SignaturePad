[![Travis CI](https://travis-ci.org/TorIsHere/SignaturePad.svg?branch=master)](https://travis-ci.org/TorIsHere/SignaturePad)

# SignaturePad

![Alt Text](https://github.com/TorIsHere/SignaturePad/raw/master/hello.gif)

Signature Pad using UIBezierPath written in Swift.
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)

## Features

- [x] Free hand drawing pad
- [x] Clear drawing pad
- [x] Pen's color selection
- [ ] Pen's size selection
- [ ] Ink pen style signature

## Installation

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.


You can use CocoaPods to install SignaturePad by adding it to your Podfile:

```ruby
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'SignaturePad', '~> 1.0.3'
end
```

Then, run the following command:

```bash
$ pod install
```

## Usage
Change your view to custom view by simply put SignaturePad to your view.

![Alt Text](https://github.com/TorIsHere/SignaturePad/raw/master/signaturepad_view.png)

#### Import
```swift
import SignaturePad

class ViewController: UIViewController {

    @IBOutlet weak var signaturePad: SignaturePad!
}
```

#### Clear
```swift
  signaturePad.clear()
```

#### Get signature
```swift
  if let signature = signaturePad.getSignature() {
      // Do Something
  }
```

#### Delegate
```swift

import SignaturePad

class ViewController: UIViewController, SignaturePadDelegate {

    @IBOutlet weak var signatureView: SignaturePad!  

    override func viewDidLoad() {
        super.viewDidLoad()
        self.signatureView.delegate = self
    }
    func didStart() {
    }

    func didFinish() {
    }
}
```

## License

SignaturePad is released under the MIT license. [See LICENSE](https://github.com/TorIsHere/SignaturePad/blob/master/LICENSE) for details.
