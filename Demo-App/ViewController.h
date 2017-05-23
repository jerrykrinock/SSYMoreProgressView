#import <UIKit/UIKit.h>

@class SSYMoreProgressView;

@interface ViewController : UIViewController

@property (weak) IBOutlet SSYMoreProgressView* progressView ;
@property (weak) IBOutlet UISlider* slider ;
- (IBAction)isVerticalAction:(id)theSwitch ;
- (IBAction)indeterminateAction:(id)theSwitch ;
- (IBAction)progressAction:(id)slider ;
- (IBAction)thicknessMultipleAction:(id)slider ;
@property (weak) IBOutlet UILabel* thicknessMultipleField ;

@property (weak) IBOutlet UILabel* titleLabel ;
@property (weak) IBOutlet UILabel* isVerticalLabel ;
@property (strong) NSSet* ourConstraints ;

@end

