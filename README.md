# TinyToast

TinyToast is simple toast library in Swift.

## Requirements
- Swift 5.1
- iOS 9.0 or later

## Installation

### Carthage

```Cartfile
github "keygx/TinyToast"
```

### Swift versions support

- Swift 5.1, tag "swift5.1"
- Swift 5, tag "swift5"
- Swift 4.2, tag "swift4.2"
- Swift 4.1, tag "swift4.1"
- Swift 4.0, tag "swift4.0"


## Usage

it will be automatically dismiss at the set time

```Swift
/* VAlign: .top / .center / .bottom */
/* Duration: .short (2.0) / .normal (3.5) / .long (5.0) / .longLong (8.0) / User setting */

TinyToast.shared.show(message: "Message you want to display", valign: .center, duration: .normal)

TinyToast.shared.show(message: "Message you want to display", valign: .center, duration: 15.0) // 15sec.
```
---

If you want to manually dismiss the first toast

```Swift
TinyToast.shared.dismiss()
```

If you want to manually dismiss all toast

```Swift
TinyToast.shared.dismissAll()
```

## Screenshots

- Support to iOS13 and Dark Mode

| Light | Dark |
|:---:|:---:|
| .top | .top |
| ![](images/portrait_top_light.png) | ![](images/portrait_top_dark.png) |
| .center | .center |
| ![](images/portrait_center_light.png) | ![](images/portrait_center_dark.png) |
| .bottom | .bottom |
| ![](images/portrait_bottom_light.png) | ![](images/portrait_bottom_dark.png) |

| Light |
|:---:|
| .top |
| ![](images/landscape_top_light.png) |
| .center |
| ![](images/landscape_center_light.png) |
| .bottom |
| ![](images/landscape_bottom_light.png) |

| Dark |
|:---:|
| .top |
| ![](images/landscape_top_dark.png) |
| .center |
| ![](images/landscape_center_dark.png) |
| .bottom |
| ![](images/landscape_bottom_dark.png) |

## License

TinyToast is released under the MIT license. See LICENSE for details.

## Author

Yukihiko Kagiyama (keygx) <https://twitter.com/keygx>
