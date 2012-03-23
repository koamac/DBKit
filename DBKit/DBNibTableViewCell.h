//
//  DBNibTableViewCell.h
//  DBKit
//
//  Created by David Barry on 7/6/11.
//  Copyright 2011 David Barry. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DBNibTableViewCell : UITableViewCell

+ (UINib *)nib;
+ (NSString *)nibName;

+ (NSString *)cellIdentifier;
+ (id)cellForTableView:(UITableView *)tableView fromNib:(UINib *)nib;

@end
