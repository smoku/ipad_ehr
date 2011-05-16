//
//  ResultTableCell.m
//  EHR
//
//  Created by Paweł Smoczyk on 11-05-14.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ResultTableCell.h"

@implementation ResultTableCell

static const CGFloat kPadding = 10;
static const CGFloat kControlPadding = 10;
static const CGFloat kBadgeCurveWidth = 9;

#define RESULT_FONT [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0f]
#define DATE_FONT [UIFont fontWithName:@"HelveticaNeue" size:14.0f]
#define NAME_FONT [UIFont fontWithName:@"HelveticaNeue" size:14.0f]

@synthesize result=_result;
@synthesize date=_date;
@synthesize name=_name;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // Labels
        
        _result = [[UILabel alloc] init];
        [_result setBackgroundColor: [UIColor clearColor]];
        [_result setFont: RESULT_FONT];
        [_result setMinimumFontSize: 20.0];
        [_result setTextColor: [UIColor blackColor]];
        [_result setLineBreakMode: UILineBreakModeTailTruncation];        
        [_result setShadowColor:[UIColor clearColor]];
        [_result setShadowOffset: CGSizeMake(0.0, -1.0)]; 
        [self.contentView addSubview: _result];
        
        _date = [[UILabel alloc] init];
        [_date setBackgroundColor: [UIColor clearColor]];
        [_date setFont: DATE_FONT];
        [_date setMinimumFontSize: 14.0];
        [_date setTextColor: [UIColor blackColor]];
        [_date setLineBreakMode: UILineBreakModeTailTruncation];        
        [_date setShadowColor:[UIColor clearColor]];
        [_date setShadowOffset: CGSizeMake(0.0, -1.0)]; 
        [_date setTextAlignment:UITextAlignmentRight];
        [self.contentView addSubview: _date];
        
        
        // Badges
        
        _name = [[TDBadgeView alloc] initWithFrame:CGRectZero];
        [_name setBackgroundColor:[UIColor clearColor]];
        [_name setBadgeColor:[UIColor colorWithRed:107.0/255.0 green:111.0/255.0 blue:114.0/255.0 alpha:1.0]];
        [_name setBadgeColorHighlighted:[UIColor blueColor]];
        [_name setBadgeTextColor:[UIColor whiteColor]];
        [_name setBadgeTextColorHighlighted:[UIColor whiteColor]];
        [_name setParent:self];
        [self.contentView addSubview:_name];
        [_name setNeedsDisplay];
        
    }
    return self;
}

- (void) layoutSubviews {
    
    CGRect resultFrame = CGRectMake(kPadding, kPadding, self.width - kPadding*2, 22.0);
    _result.frame = resultFrame;
    
    CGRect dateFrame = CGRectMake(self.right - kPadding - 100, _result.bottom + kControlPadding, 100, 20.0);
    _date.frame = dateFrame;
    
    CGSize nameSize = [_name.badgeString sizeWithFont:NAME_FONT forWidth:500.0 lineBreakMode:UILineBreakModeTailTruncation];
    CGRect nameFrame = CGRectMake(kPadding, _result.bottom + kControlPadding, nameSize.width + kBadgeCurveWidth*3, 20.0);
    _name.frame = nameFrame;
    
    if ([self isEditing]) {        
        dateFrame.origin.x = dateFrame.origin.x - 80;
        _date.frame = dateFrame;
    }
    
    [super layoutSubviews];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
	[super setHighlighted:highlighted animated:animated];
	[_name setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];
	[_name setNeedsDisplay];
}

- (void)dealloc
{
    [_result release];
    [_date release];
    [_name release];

    [super dealloc];
}

@end
