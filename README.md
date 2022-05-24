# DefibHeart

We spend a lot of time looking at heart icons but not thinking about the organ they represent. I've had my life saved by a defibrillator and I now have one with me at all times in the form of a pacemaker. I thought it would be a nice to use a defib to bring a heart animation to life.

![Defib Heart](https://user-images.githubusercontent.com/2143656/170134149-95c59fd9-4770-4ce2-b455-043589ef5fe0.gif)



*Submission for [SwiftUISeries](https://www.swiftuiseries.com) - Animations*

# How does it work?
- All values are linked to a single size value so it can easily be resized.
- I created an enum called Keyframe and cycled through the values to trigger each key of the animation in sequence. The delay parameter ensures each keyframe is appropriately staggered.
- The beating heart at the end was a bit tricky and required a local .animation modifier to override the other animations.
- The shapes are each drawn separately with some help from package I made called:

<a href="https://github.com/ryanlintott/ShapeUp">
  <img width="456" alt="ShapeUp Logo" src="https://user-images.githubusercontent.com/2143656/157464613-38fd35cc-7802-4cb7-914b-4da480a0411e.png">
</a>
