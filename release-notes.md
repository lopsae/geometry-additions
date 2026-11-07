Release Notes
=============

v0.6.3 - More Additions
-----------------------
+ Added `CGPoint/init(on:Axis)` and `CGPoint/setting` function.
+ Added `CGPoint/adding(_:orthogonal:along:)` function.
+ Added `CGPoint/adding(_:orthogonal:towards:)` function.
+ Added `CGSize/length(along:)` function.
+ Added `CGRect/edgeCenterPoint(on:)` function.


v0.6.2 - More Additions
-----------------------
+ Renamed `CGPoint/offset` functions to `adding`.
+ Renamed `CGRect/offset` function to `offsetting`.
+ Added `CGPoint/add` function.
+ Added `CGRect/topCenterPoint`, `leadingCenterPoint`, `bottomCenterPoint`, and `trailingCenterPoint` properties. 
+ Added `CGRect/horizontalBisector` and `verticalBisector` properties.
+ Added `CGRect/envelop` and `enveloping` functions.


v0.6.1 - Publicize API
----------------------
Released 2026 September 20th.
+ Document and publicize API for `CGPoint`, `CGSize`, and `CGRect`.


v0.6.0 - Initial Release
------------------------
Released 2026 August 26th.

+ Initial package release.
+ Moved additions for `CGPoint`, `CGSize`, `CGRect`, `EdgeInsets`, and `UIEdgeInsets` from `PreviewUtilities`.
