//
//  MedicationTableCell.h
//  EHR
//
//  Created by Paweł Smoczyk on 11-04-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDBadgedCell.h"
#import "UIVIew+Sizes.h"

@interface MedicationTableCell : UITableViewCell {
    UILabel* _name;
    UILabel* _date;
    
    TDBadgeView* _strength;
    TDBadgeView* _frequency;
    TDBadgeView* _route;    
}

@property (nonatomic, retain) UILabel* name;
@property (nonatomic, retain) UILabel* date;

@property (nonatomic, retain) TDBadgeView* strength;
@property (nonatomic, retain) TDBadgeView* frequency;
@property (nonatomic, retain) TDBadgeView* route;

@end

