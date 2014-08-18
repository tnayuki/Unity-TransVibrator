Unity-TransVibrator
===================

TransVibrator plugin for Unity.

Now Mac OS only.

## Installation

Import Unity-TransVibrator.unitypackage to your project. 

## Usage

You can vibrate the TransVibrator by following method. 

```
TransVibrator.VibrateAll(0-1.0f)
```

When you connected multiple TransVibrators, you can vibrate it separately by following method.

```
TransVibrator.Vibrate(index, 0-1.0f)
```

## Contributing

1. Fork it ( http://github.com/tnayuki/Unity-TransVibrator/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## LTIOUSB

This software includes non-ARC-modified LTIOUSB library.

Copyright (c) 2013 Yusuke Ito  
Released under the MIT license  
https://github.com/novi/LTIOUSB  
