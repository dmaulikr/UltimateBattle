CGPoint CombinedPoint(CGPoint a, CGPoint b) {
    CGPoint combinedPoint = CGPointMake(a.x + b.x, a.y + b.y);
    return combinedPoint;
}

CGPoint MultipliedPoint(CGPoint p, float modifier) {
    CGPoint multipliedPoint = CGPointMake(p.x * modifier, p.y * modifier);
    return multipliedPoint;
}