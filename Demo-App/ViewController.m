#import "ViewController.h"
#import "SSYMoreProgressView.h"


@implementation ViewController

- (IBAction)isVerticalAction:(UISwitch*)theSwitch {
    self.progressView.isVertical = theSwitch.isOn;
}

- (IBAction)indeterminateAction:(UISwitch*)theSwitch {
    self.progressView.indeterminate = theSwitch.isOn;
    // See SSYMoreProgressView.m > Notes : ProgressTrackColor
    if (theSwitch.isOn) {
        self.slider.value = 0.0 ;
    }
}

- (IBAction)progressAction:(UISlider*)slider {
    self.progressView.progress = slider.value;
}

- (IBAction)thicknessMultipleAction:(UISlider*)slider {
    self.progressView.thicknessMultiple = slider.value;
    NSString* string = [[NSString alloc] initWithFormat:@"%0.1f", slider.value] ;
    self.thicknessMultipleField.text = string ;
}

- (void)fixLayout {
    /* Add two Auto Layout constraints which ensure that the vertical space for
     the progress view tall is enough to accomodate vertical orientation.  I do
     do these in code because they were too complicated to express in Interface
     Builder. */
    
    CGFloat margin = 8.0 ;
    CGFloat halfHeight = self.progressView.bounds.size.width / 2 + margin ;
    NSLayoutConstraint* constraint1 = [NSLayoutConstraint constraintWithItem:self.progressView
                                              attribute:NSLayoutAttributeTop
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.titleLabel
                                              attribute:NSLayoutAttributeBottom
                                             multiplier:1.0
                                               constant:halfHeight] ;
    
    NSLayoutConstraint* constraint2 = [NSLayoutConstraint constraintWithItem:self.isVerticalLabel
                                              attribute:NSLayoutAttributeTop
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.progressView
                                              attribute:NSLayoutAttributeBottom
                                             multiplier:1.0
                                               constant:halfHeight] ;

    for (NSLayoutConstraint* constraint in self.ourConstraints) {
        [self.view removeConstraint:constraint] ;
    }
    [self.view addConstraint:constraint1] ;
    [self.view addConstraint:constraint2] ;
    
    self.ourConstraints = [NSSet setWithObjects:constraint1, constraint2, nil] ;
}

- (void)viewDidLoad {
    [self fixLayout] ;
    
    [self.progressView addObserver:self
                        forKeyPath:@"bounds"
                           options:0
                           context:NULL] ;

}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"bounds"]) {
        if (object == self.progressView) {
            [self fixLayout] ;
        }
    }
}


@end
