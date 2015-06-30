//
//  SelectedCustonButton.m
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-15.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "SelectedCustonButton.h"

@implementation SelectedCustonButton

//- (id)initWithFrame:(CGRect)frame
//{
//    frame.size.width = 23;
//    frame.size.height = 23;
//    self = [super initWithFrame:frame];
//    if (self) {
//        _selectedIMG = [UIImage imageNamed:@"selected.png"];
//        _noselectedIMG = [UIImage imageNamed:@"noselected.png"];
//        
//        _iView = [[UIImageView alloc]initWithFrame:self.bounds];
//        _iView.image = _noselectedIMG;
//
//        _isOn = NO;
//        [self addSubview:_iView];
//    }
//    return self;
//}


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, 23,23);
    
    _selectedIMG = [UIImage imageNamed:@"selected.png"];
    _noselectedIMG = [UIImage imageNamed:@"noselected.png"];
    
    _iView = [[UIImageView alloc]initWithFrame:self.bounds];
    _iView.image = _noselectedIMG;
    
    _isOn = NO;
    [self addSubview:_iView];
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.isOn = !self.isOn;
}


-(void)setIsOn:(BOOL)isOn
{
    if (_isOn!=isOn) {
        _isOn = isOn;
        if (_isOn) {
            _iView.image=_selectedIMG;
        }
        else
        {
            _iView.image=_noselectedIMG;
        }
        
        if ([_target respondsToSelector:_selector]) {
            [_target performSelector:_selector withObject:nil afterDelay:0];
        }
    }
}

-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    if (controlEvents & UIControlEventValueChanged) {
        _target=target;
        _selector=action;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
