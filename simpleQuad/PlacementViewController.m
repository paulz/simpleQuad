//
//  PlacementViewController.m
//  simpleQuad
//
//  Created by Paul Zabelin on 1/28/16.
//  Copyright © 2016 Flowering Dahlia. All rights reserved.
//

#import "PlacementViewController.h"
#import "simpleQuad-Swift.h"
@import QuartzCore;
@import ImageCoordinateSpace;

@interface PlacementViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *container;
@property (weak, nonatomic) IBOutlet UIView *overlay;

@end

@implementation PlacementViewController
- (IBAction)changeMode:(UIButton *)sender {
    NSInteger mode = self.container.contentMode;
    mode += 1;
    mode %= UIViewContentModeBottomRight + 1;
    NSLog(@"content mode: %@", @(mode));
    self.container.contentMode = mode;
    [self placeOverlay];
}

- (CGPoint)viewPointFromPixelPoint:(CGPoint)point {
    return [self.container.imageCoordinateSpace convertPoint:point toCoordinateSpace:self.container];
}

- (void)placeOverlay {
    CGPoint topLeft = CGPointMake(96, 119);
    CGPoint topRight = CGPointMake(361, 101);
    CGPoint bottomLeft = CGPointMake(118, 473);
    CGPoint bottomRight = CGPointMake(382, 457);



    Quadrilateral *quad = [Quadrilateral new];
    quad.topLeft = [self viewPointFromPixelPoint:topLeft];
    quad.topRight = [self viewPointFromPixelPoint:topRight];
    quad.bottomLeft = [self viewPointFromPixelPoint:bottomLeft];
    quad.bottomRight = [self viewPointFromPixelPoint:bottomRight];

    [UIView animateWithDuration:1.0 animations:^{
        self.overlay.frame = [quad box];
        self.overlay.layer.transform = [quad transformToFit:self.overlay.bounds anchorPoint:self.overlay.layer.position];
    }];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self placeOverlay];
}


- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
