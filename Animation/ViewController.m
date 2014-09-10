
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    _imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _imageView.layer.borderWidth = 3.0f;
    _imageView.layer.cornerRadius = 10.0f;
}

- (IBAction)implictAnimation:(id)sender
{
    //MacOS
    //_imageView.layer.opacity = _imageView.layer.opacity == 0 ? 1 : 0;

    //iOS
    [UIView animateWithDuration:1.0 animations:^{
        _imageView.layer.opacity = _imageView.layer.opacity == 0 ? 1 : 0;
    }];
}

- (IBAction)explictAnimation:(id)sender
{
    float opacity = _imageView.layer.opacity;
    CABasicAnimation* fadeAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnim.fromValue = opacity == 1 ? @1.0 : @0.0;
    fadeAnim.toValue = opacity == 1 ? @0.0 : @1.0;

    fadeAnim.duration = 1.0;
    [_imageView.layer addAnimation:fadeAnim forKey:@"opacity"];
    
    //change model layer
    _imageView.layer.opacity = !opacity;
}

- (IBAction)groupAnimation:(id)sender
{
    CABasicAnimation *fadeAnim=[CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnim.fromValue=[NSNumber numberWithDouble:1.0];
    fadeAnim.toValue=[NSNumber numberWithDouble:0.2];
    
    CABasicAnimation *rotateAnim=[CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotateAnim.fromValue=[NSNumber numberWithDouble:0.0];
    rotateAnim.toValue=[NSNumber numberWithDouble:M_PI];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 2;
    group.repeatCount = 1;
    group.autoreverses = YES;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.animations = [NSArray arrayWithObjects:fadeAnim, rotateAnim, nil];
    
    [_imageView.layer addAnimation:group forKey:@"allMyAnimations"];
}

- (IBAction)keyFrameAnimation:(id)sender
{
    CAKeyframeAnimation* colorAnim = [CAKeyframeAnimation animationWithKeyPath:@"borderColor"];
    NSArray* colorValues = [NSArray arrayWithObjects:(id)[UIColor greenColor].CGColor,
                            (id)[UIColor redColor].CGColor, (id)[UIColor blueColor].CGColor,  nil];
    colorAnim.values = colorValues;
    colorAnim.duration = 0.4;
    colorAnim.calculationMode = kCAAnimationPaced;
    
    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animation];
    moveAnim.keyPath = @"position.x";
    moveAnim.values = @[ @0, @20, @-20, @20, @0 ];
    moveAnim.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
    moveAnim.duration = 0.4;
    moveAnim.additive = YES;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 2;
    group.repeatCount = 1;
    group.autoreverses = YES;
    group.animations = [NSArray arrayWithObjects:colorAnim, moveAnim, nil];
    [_imageView.layer addAnimation:group forKey:@"allMyAnimations"];
}

- (IBAction)transitionAnimation:(id)sender
{
    CATransition* transition = [CATransition animation];
    transition.startProgress = 0;
    transition.endProgress = 1.0;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    transition.duration = 1.0;
    
    [_imageView.layer addAnimation:transition forKey:@"transition"];
    [_imageView1.layer addAnimation:transition forKey:@"transition"];
}

@end
