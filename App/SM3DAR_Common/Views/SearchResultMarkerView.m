//
//  SearchResultMarkerView.m
//
//  Created by P. Mark Anderson on 12/1/09.
//  Copyright 2009 Bordertown Labs, LLC. All rights reserved.
//

#import "SearchResultMarkerView.h"

#define MIN_SIZE_SCALAR 0.75
#define SCALE_REDUCTION 1.0

@implementation SearchResultMarkerView

- (void) buildView {
    // could also use bubble1.png
	UIImage *img = [UIImage imageNamed:[[self class] randomIconName]];
    UIImageView *iv = [[UIImageView alloc] initWithImage:img];
	self.icon = iv;
    [iv release];
	self.frame = CGRectMake(0, 0, img.size.width, img.size.height);
    self.backgroundColor = [UIColor blackColor];
    
    CALayer *l = self.layer;
    [l setMasksToBounds:YES];
    [l setCornerRadius:8.0];
    [l setBorderWidth:2.0];
    [l setBorderColor:[[UIColor whiteColor] CGColor]];
    
	[self addSubview:self.icon];
}

- (void) didReceiveFocus {  
    [self.superview bringSubviewToFront:self];
}

- (void) didLoseFocus {
}

- (CGFloat) rangeScalar {
    CGFloat scalar;
	CGFloat poiDistance = [self.poi distanceInMetersFromCurrentLocation];
    
    SM3DAR_Controller *sm3dar = [SM3DAR_Controller sharedController];
	CGFloat minRange = sm3dar.nearClipMeters;
	CGFloat maxRange = sm3dar.farClipMeters;
    
	if (poiDistance > maxRange || poiDistance < minRange) {
		scalar = 0.001;
        
	} else {
		CGFloat scaleFactor = 1.0;
		CGFloat rangeU = (poiDistance - minRange) / (maxRange - minRange);
        
        scalar = 1.0 - (scaleFactor * rangeU);
        
        scalar *= SCALE_REDUCTION; // because I think they look better smaller
        
        if (scalar < MIN_SIZE_SCALAR)
            scalar = MIN_SIZE_SCALAR;
	}	
    
    return scalar;
}

// pointTransform is called automatically
- (CGAffineTransform) pointTransform {
    CGFloat scalar;
    if (self.poi.hasFocus) {
        scalar = 2.0f;
    } else {
        scalar = [self rangeScalar];
        
        CGFloat range1 = SCALE_REDUCTION * 0.66;
        CGFloat range2 = SCALE_REDUCTION * 0.33;
        
        if (scalar < range1) {
            self.alpha = 0.3;
        } if (scalar < range2) {
            self.alpha = 0.15;
        } else {
            self.alpha = 1.0;
        }
    }        

    return CGAffineTransformMakeScale(scalar, scalar);
}

@end
