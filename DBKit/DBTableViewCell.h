//
//  DBTableViewCell.h
//  DBKit
//
//  Created by David Barry on 7/6/11.
//  Copyright 2011 David Barry. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DBTableViewCell : UITableViewCell 

+ (id)cellForTableView:(UITableView *)tableView;
+ (NSString *)cellIdentifier;

- (id)initWithCellIdentifier:(NSString *)cellID;
@end
