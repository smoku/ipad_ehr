//
//  ResultTableCell.h
//  EHR
//
//  Created by Paweł Smoczyk on 11-05-14.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDBadgedCell.h"
#import "UIVIew+Sizes.h"

@interface ResultTableCell : UITableViewCell {
    UILabel* _result;
    UILabel* _date;
    
    TDBadgeView* _name;
}

@property (nonatomic, retain) UILabel* result;
@property (nonatomic, retain) UILabel* date;

@property (nonatomic, retain) TDBadgeView* name;

@end
