# UILabel testing with ARKit

1. The problem is that `UILabels` have trouble rendering when presented in AR. I think this is because when they are far away from the camera, or at a particular angle, then the text won't render properly, so the label doesn't get attached to its `SCNPlane`.

2. The hack is to convert each `UILabel` to a `UIImage`, and then render that instead.

Relevant class is `ImageFromLabel`


- see [here](https://stackoverflow.com/questions/47406334/uilabel-text-doesnt-appear-when-using-arkit) for my original SO question.
- [this](https://stackoverflow.com/questions/11867152/how-to-create-an-image-from-uilabel) question describes how to generate the image from the label
