# CircleStrokeSpin

Animation 32 from
[ninjaprox/NVActivityIndicatorView](https://github.com/ninjaprox/NVActivityIndicatorView)
wrapped for use with SwiftUI.
This animation isn't available in
[ninjaprox/LoaderUI](https://github.com/ninjaprox/LoaderUI)

I just wrapped the original animation with UIViewRepresentable because
I coudln't create 2 simultaneous animations with different timing curves in pure
SwiftUI. However, the wrapping doesn't work completely nice:

+ The foregroundColor modifier doesn't affect the view
+ you need to pass CGColor to the constructor

See the code for usage. Basically, you need to copy CircleStrokeSpin.swift to
your project and you are ready to go!
