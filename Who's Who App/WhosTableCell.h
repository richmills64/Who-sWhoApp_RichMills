//
//  WhosTableCell.h
//  Who's Who App
//
//  Created by Richard Mills on 11/12/2013.
//  Copyright (c) 2013 Richard Mills. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WhosTableCell : UITableViewCell

-(void)setImage:(UIImage*)image;

-(void)setUserName:(NSString*)name;

-(void)setTitle:(NSString*)title;

-(void)setDetail:(NSString*)detail;

+ (CGFloat)height;
@end
