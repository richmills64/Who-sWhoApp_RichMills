//
//  StartView.m
//  Who's Who App
//
//  Created by Richard Mills on 11/12/2013.
//  Copyright (c) 2013 Richard Mills. All rights reserved.
//

#import "StartView.h"

@implementation StartView{
    UIImageView * logo_C;
    UIImageView * logo_TL;
    UIImageView * logo_TR;
    UIImageView * logo_BL;
    UIImageView * logo_BR;
    UILabel * title;
    UIActivityIndicatorView *activityIndicator;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#define LOGO_HEIGHT 90
#define LOGO_WIDTH 90
- (void)drawRect:(CGRect)rect
{
    self.backgroundColor = [UIColor whiteColor];
    
    logo_TL = [[UIImageView alloc]initWithFrame:CGRectMake(-LOGO_WIDTH, -LOGO_HEIGHT, LOGO_WIDTH, LOGO_HEIGHT)];
    logo_TL.image = [UIImage imageNamed:@"logo_tab_tl.png"];
    logo_TL.backgroundColor = [UIColor clearColor];
    [self addSubview:logo_TL];
    
    logo_TR = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width +LOGO_WIDTH, -LOGO_HEIGHT, LOGO_WIDTH, LOGO_HEIGHT)];
    logo_TR.image = [UIImage imageNamed:@"logo_tab_tr.png"];
    logo_TR.backgroundColor = [UIColor clearColor];
    [self addSubview:logo_TR];
    
    logo_BL = [[UIImageView alloc]initWithFrame:CGRectMake(-LOGO_WIDTH, self.bounds.size.height +LOGO_HEIGHT, LOGO_WIDTH, LOGO_HEIGHT)];
    logo_BL.image = [UIImage imageNamed:@"logo_tab_bl.png"];
    logo_BL.backgroundColor = [UIColor clearColor];
    [self addSubview:logo_BL];
    
    logo_BR = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width +LOGO_WIDTH, self.bounds.size.height +LOGO_HEIGHT, LOGO_WIDTH, LOGO_HEIGHT)];
    logo_BR.image = [UIImage imageNamed:@"logo_tab_br.png"];
    logo_BR.backgroundColor = [UIColor clearColor];
    [self addSubview:logo_BR];
    
    logo_C = [[UIImageView alloc]initWithFrame:CGRectMake((self.bounds.size.width/2)-(LOGO_WIDTH/2), (self.bounds.size.height/2)-LOGO_HEIGHT, LOGO_WIDTH, LOGO_HEIGHT)];
    logo_C.image = [UIImage imageNamed:@"logo_tab_center.png"];
    logo_C.backgroundColor = [UIColor clearColor];
    logo_C.alpha = 0.0;
    [self addSubview:logo_C];
    
    title = [[UILabel alloc]initWithFrame:CGRectMake(0, (self.bounds.size.height/2),self.bounds.size.width, 35)];
    title.text = @"Who's Who App";
    title.textAlignment =  NSTextAlignmentCenter ;
    [title setFont:[UIFont boldSystemFontOfSize:25.0]];
    title.textColor = [UIColor blackColor];
    title.alpha = 0.0;
    [title setBackgroundColor:[ UIColor clearColor]];
    [self addSubview:title];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.alpha = 0.0;
    activityIndicator.center = CGPointMake(160, 340);
    activityIndicator.hidesWhenStopped = NO;
    [self addSubview:activityIndicator];
}
-(void)beginAnimation{
    [UIView animateWithDuration:2.0 animations:^{
        logo_TL.frame = CGRectMake((self.bounds.size.width/2)-(LOGO_WIDTH/2), (self.bounds.size.height/2)-LOGO_HEIGHT, LOGO_WIDTH, LOGO_HEIGHT);
        logo_BR.frame = CGRectMake((self.bounds.size.width/2)-(LOGO_WIDTH/2), (self.bounds.size.height/2)-LOGO_HEIGHT, LOGO_WIDTH, LOGO_HEIGHT);
        logo_TR.frame = CGRectMake((self.bounds.size.width/2)-(LOGO_WIDTH/2), (self.bounds.size.height/2)-LOGO_HEIGHT, LOGO_WIDTH, LOGO_HEIGHT);
        logo_BL.frame = CGRectMake((self.bounds.size.width/2)-(LOGO_WIDTH/2), (self.bounds.size.height/2)-LOGO_HEIGHT, LOGO_WIDTH, LOGO_HEIGHT);
        }completion:^(BOOL finished) {
          [UIView animateWithDuration:1.5 animations:^{
                logo_C.alpha = 1.0;
                title.alpha = 1.0;
                activityIndicator.alpha = 1.0;
                [activityIndicator startAnimating];
          }];
        
    }];

 
   
}

@end
