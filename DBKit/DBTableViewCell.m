//
//  DBTableViewCell.m
//  DBKit
//
//  Created by David Barry on 7/6/11.
//  Copyright 2011 David Barry. All rights reserved.
//

#import "DBTableViewCell.h"


@implementation DBTableViewCell

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

+ (id)cellForTableView:(UITableView *)tableView {
    NSString *cellID = [self cellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc] initWithCellIdentifier:cellID];
    }
    return cell;    
}


- (id)initWithCellIdentifier:(NSString *)cellID {
    return [self initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
}

@end
