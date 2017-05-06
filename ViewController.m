//
//  ViewController.m
//  Drawing
//
//  Created by Admin on 28.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISlider *slider1;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIImageView *canvas;
@property CGPoint lastPoint;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    [self setLastPoint:[touch locationInView:self.view]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    UIGraphicsBeginImageContext(self.view.frame.size);
    CGRect drawRect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width,
                                 self.view.frame.size.height);
    [[[self canvas] image] drawInRect:drawRect];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), [[self slider] value]);
    int colorArray[] = { 0x000000, 0xfe0000, 0xff7900, 0xffb900, 0xffde00, 0xfcff00, 0xd2ff00, 0x05c000, 0x00c0a7, 0x0600ff, 0x6700bf, 0x9500c0, 0xbf0199, 0xffffff };
    int index = [[self slider1] value];
    int rgbValue = colorArray[index];
    float red = ((rgbValue & 0xFF0000) >> 16) / 255.0;
    float green = ((rgbValue & 0x00FF00) >> 8) / 255.0;
    float blue =  (rgbValue & 0x0000FF) / 255.0;
    float alpha = 1.0;

    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, alpha);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), _lastPoint.x, _lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    [[self canvas] setImage:UIGraphicsGetImageFromCurrentImageContext()]; 
    UIGraphicsEndImageContext();
    _lastPoint = currentPoint;
    
    NSString  *jpgPath = @"~/Desktop/Pic.jpg";
    
    // Write a UIImage to JPEG with minimum compression (best quality)
    // The value 'image' must be a UIImage object
    // The value '1.0' represents image compression quality as value from 0.0 to 1.0
    [UIImageJPEGRepresentation(self.canvas.image, 1.0) writeToFile:jpgPath atomically:YES];
}

@end
