import Cocoa

fileprivate let pointSize: CGFloat = 5
fileprivate let halfPointSize: CGFloat = pointSize / 2
fileprivate let handleSize: CGFloat = 3
fileprivate let halfHandleSize: CGFloat = handleSize / 2
fileprivate let handleLineWidth: CGFloat = 1.5
fileprivate let defaultPointColor = NSColor.red
fileprivate let defaultHandleColor = NSColor.green

extension NSBezierPath {
  func drawPointsAndHandles() {
    drawPoints(inColor: defaultPointColor, withHandlesInColor: defaultHandleColor)
  }

  func drawPoints(inColor pointColor: NSColor, withHandlesInColor handleColor: NSColor) {
    var previousPoint = NSPoint.zero

    for i in (0..<elementCount) {
      previousPoint = drawPathElement(
        i,
        withPreviousPoint: previousPoint,
        inColor: pointColor,
        withHandlesInColor: handleColor
      )
    }
  }

  func drawPoint(_ point: NSPoint) {
    drawPoint(point, inColor: defaultPointColor)
  }

  func drawPoint(_ point: NSPoint, inColor color: NSColor) {
    let rect = NSRect(x: point.x - halfPointSize,
                      y: point.y - halfPointSize,
                      width: pointSize,
                      height: pointSize)
    let pointPath = NSBezierPath(rect: rect)
    color.setFill()
    pointPath.fill()
  }

  func drawHandlePoint(_ point: NSPoint) {
    drawHandlePoint(point, inColor: defaultHandleColor)
  }

  func drawHandlePoint(_ point: NSPoint, inColor color: NSColor) {
    let rect = NSRect(x: point.x - halfHandleSize,
                      y: point.y - halfHandleSize,
                      width: handleSize,
                      height: handleSize)
    let handlePath = NSBezierPath(rect: rect)
    color.setFill()
    handlePath.fill()
  }

  func drawPathElement(_ n: Int, withPreviousPoint previous: NSPoint) -> NSPoint {
    return drawPathElement(n,
                           withPreviousPoint: previous,
                           inColor: defaultPointColor,
                           withHandlesInColor: defaultHandleColor)
  }

  func drawPathElement(_ n: Int,
            withPreviousPoint previous: NSPoint,
            inColor pointColor: NSColor,
            withHandlesInColor handleColor: NSColor) -> NSPoint {
    var previousPoint: NSPoint
    var points = [CGPoint](repeating: .zero, count: 3)
    let element = self.element(at: n, associatedPoints: &points)
    let path = NSBezierPath()

    switch element {
    case .curveToBezierPathElement:
      path.move(to: previous)
      path.line(to: points[0])
      path.move(to: points[2])
      path.line(to: points[1])
      path.lineWidth = handleLineWidth
      handleColor.setStroke()
      path.stroke()
      drawHandlePoint(points[0], inColor: handleColor)
      drawHandlePoint(points[1], inColor: handleColor)
      drawPoint(points[2], inColor: pointColor)
      previousPoint = points[2]
    case .moveToBezierPathElement:
      drawPoint(points[0], inColor: pointColor)
      previousPoint = points[0]
    case .lineToBezierPathElement:
      drawPoint(points[0], inColor: pointColor)
      previousPoint = points[0]
    case .closePathBezierPathElement:
      previousPoint = points[0]
    }
    return previousPoint
  }
}
