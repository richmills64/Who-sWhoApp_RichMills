//
//  WhosTableCell.m
//  Who's Who App
//
//  Created by Richard Mills on 11/12/2013.
//  Copyright (c) 2013 Richard Mills. All rights reserved.
//

#import "WhosTableCell.h"
#import <QuartzCore/QuartzCore.h>
@implementation WhosTableCell{
    UIImageView * userImageView;
    UILabel *userName;
    UILabel *userTitle;
    UITextView *userDetail;
}
#define IMAGE_SIZE 150
#define NAME_TITLE_HEIGHT 30
#define DETAIL_HEIGHT 220

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView * background = [[UIView alloc]initWithFrame:CGRectMake(5, IMAGE_SIZE - 20, self.frame.size.width - 10, (NAME_TITLE_HEIGHT*2)+DETAIL_HEIGHT + 10)];
        background.backgroundColor = [UIColor whiteColor];
        CALayer *iconlayer = background.layer;
        iconlayer.masksToBounds = NO;
        iconlayer.cornerRadius = 8.0;
        iconlayer.shadowOffset = CGSizeMake(-2.0, 2.0);
        iconlayer.shadowRadius = 3.0;
        iconlayer.shadowOpacity = 0.2;
        [self addSubview:background];
        
        userImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width/2)-(IMAGE_SIZE/2), 0, IMAGE_SIZE, IMAGE_SIZE)];
        userImageView.clipsToBounds = YES;
        userImageView.contentMode =UIViewContentModeScaleAspectFill;
        CALayer *imageLayer = userImageView.layer;
        [imageLayer setCornerRadius:IMAGE_SIZE/2];
        [imageLayer setMasksToBounds:YES];
        [imageLayer setBorderWidth:5.0f];
        [imageLayer setBorderColor:[UIColor whiteColor].CGColor];
        [self addSubview:userImageView];
        
        userName = [[UILabel alloc] initWithFrame:CGRectMake(0,IMAGE_SIZE,self.frame.size.width,NAME_TITLE_HEIGHT)];
        userName.font = [UIFont systemFontOfSize:21];
        userName.textAlignment =  NSTextAlignmentCenter ;
        userName.numberOfLines = 0;
        userName.textColor = [UIColor blackColor];
        userName.backgroundColor = [UIColor clearColor];
        [self addSubview:userName];
        
        userTitle = [[UILabel alloc] initWithFrame:CGRectMake(0,IMAGE_SIZE+NAME_TITLE_HEIGHT,self.frame.size.width,NAME_TITLE_HEIGHT)];
        userTitle.font = [UIFont systemFontOfSize:18];
        userTitle.textAlignment =  NSTextAlignmentCenter ;
        userTitle.numberOfLines = 0;
        userTitle.textColor = [UIColor darkGrayColor];
        userTitle.backgroundColor = [UIColor clearColor];
        [self addSubview:userTitle];
        
        userDetail = [[UITextView alloc]initWithFrame: CGRectMake(10,IMAGE_SIZE+(NAME_TITLE_HEIGHT*2),self.frame.size.width-20,DETAIL_HEIGHT)];
        userDetail.textColor = [UIColor lightGrayColor];
        userDetail.textAlignment =  NSTextAlignmentCenter ;
        userDetail.font = [UIFont systemFontOfSize:16];
        userDetail.editable = NO;
        userDetail.backgroundColor = [UIColor clearColor];
        [self addSubview:userDetail];
    }
    return self;
}
-(void)setImage:(UIImage*)image{
    
    userImageView.image = image;
}
-(void)setUserName:(NSString*)name{
    userName.text = name;
}

-(void)setTitle:(NSString*)title{
    userTitle.text = title;
}

-(void)setDetail:(NSString*)detail{
    userDetail.text = detail;
}
+ (CGFloat)height{
    
    return IMAGE_SIZE+(NAME_TITLE_HEIGHT*2)+ DETAIL_HEIGHT;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
