#import <UIKit/UIKit.h>

@interface DrawView_Smoothing : UIView

-(id) initWithFrame:(CGRect)frame :(int) w andHeight:(int) h;
- (void) eraser;
- (void) pen;
@property NSString *title;
@property UIImage *screenImage;
@property NSObject *buttons;


@end
