//
//  MedicationTableCell.m
//  EHR
//
//  Created by Paweł Smoczyk on 11-04-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MedicationTableCell.h"


@implementation MedicationTableCell

static const CGFloat kPadding = 10;
static const CGFloat kControlPadding = 10;
static const CGFloat kBadgeCurveWidth = 9;

#define NAME_FONT [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0f]
#define DATE_FONT [UIFont fontWithName:@"HelveticaNeue" size:14.0f]
#define ROUTE_FONT [UIFont fontWithName:@"HelveticaNeue" size:14.0f]
#define STRENGTH_FONT [UIFont fontWithName:@"HelveticaNeue" size:14.0f]
#define FREQUENCY_FONT [UIFont fontWithName:@"HelveticaNeue" size:14.0f]

@synthesize name=_name;
@synthesize date=_date;

@synthesize strength=_strength;
@synthesize frequency=_frequency;
@synthesize route=_route;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // Labels
        
        _name = [[UILabel alloc] init];
        [_name setBackgroundColor: [UIColor clearColor]];
        [_name setFont: NAME_FONT];
        [_name setMinimumFontSize: 20.0];
        [_name setTextColor: [UIColor blackColor]];
        [_name setLineBreakMode: UILineBreakModeTailTruncation];        
        [_name setShadowColor:[UIColor clearColor]];
        [_name setShadowOffset: CGSizeMake(0.0, -1.0)]; 
        [self.contentView addSubview: _name];

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
        
        _strength = [[TDBadgeView alloc] initWithFrame:CGRectZero];
        [_strength setBackgroundColor:[UIColor clearColor]];
        [_strength setBadgeColor:[UIColor colorWithRed:107.0/255.0 green:111.0/255.0 blue:114.0/255.0 alpha:1.0]];
        [_strength setBadgeColorHighlighted:[UIColor blueColor]];
        [_strength setBadgeTextColor:[UIColor whiteColor]];
        [_strength setBadgeTextColorHighlighted:[UIColor whiteColor]];
        [_strength setParent:self];
        [self.contentView addSubview:_strength];
        [_strength setNeedsDisplay];
        
        _frequency = [[TDBadgeView alloc] initWithFrame:CGRectZero];
        [_frequency setBackgroundColor:[UIColor clearColor]];
        [_frequency setBadgeColor:[UIColor colorWithRed:107.0/255.0 green:111.0/255.0 blue:114.0/255.0 alpha:1.0]];
        [_frequency setBadgeColorHighlighted:[UIColor blueColor]];
        [_frequency setBadgeTextColor:[UIColor whiteColor]];
        [_frequency setBadgeTextColorHighlighted:[UIColor whiteColor]];
        [_frequency setParent:self];
        [self.contentView addSubview:_frequency];
        [_frequency setNeedsDisplay];
        
        _route = [[TDBadgeView alloc] initWithFrame:CGRectZero];
        [_route setBackgroundColor:[UIColor clearColor]];
        [_route setBadgeColor:[UIColor colorWithRed:107.0/255.0 green:111.0/255.0 blue:114.0/255.0 alpha:1.0]];
        [_route setBadgeColorHighlighted:[UIColor blueColor]];
        [_route setBadgeTextColor:[UIColor whiteColor]];
        [_route setBadgeTextColorHighlighted:[UIColor whiteColor]];
        [_route setParent:self];
        [self.contentView addSubview:_route];
        [_route setNeedsDisplay];
        
    }
    return self;
}

- (void) layoutSubviews {

    CGSize routeSize = [_route.badgeString sizeWithFont:ROUTE_FONT forWidth:60.0 lineBreakMode:UILineBreakModeTailTruncation];
    CGRect routeFrame = CGRectMake(self.right - kPadding - routeSize.width - kBadgeCurveWidth*2, kPadding, routeSize.width + kBadgeCurveWidth*3, 20.0);
    _route.frame = routeFrame;
    
    CGRect nameFrame = CGRectMake(kPadding, kPadding, _route.left - kPadding - kControlPadding, 22.0);
    _name.frame = nameFrame;
    
    CGRect dateFrame = CGRectMake(self.right - kPadding - 170, _name.bottom + kControlPadding, 170, 20.0);
    _date.frame = dateFrame;
    
    CGSize strengthSize = [_strength.badgeString sizeWithFont:STRENGTH_FONT forWidth:100.0 lineBreakMode:UILineBreakModeTailTruncation];
    CGRect strengthFrame = CGRectMake(kPadding, _name.bottom + kControlPadding, strengthSize.width + kBadgeCurveWidth*3, 20.0);
    _strength.frame = strengthFrame;
    
    CGSize frequencySize = [_frequency.badgeString sizeWithFont:FREQUENCY_FONT forWidth:250.0 lineBreakMode:UILineBreakModeTailTruncation];
    CGRect frequencyFrame = CGRectMake(_strength.right + kControlPadding, _name.bottom + kControlPadding, frequencySize.width + kBadgeCurveWidth*4, 20.0);
    _frequency.frame = frequencyFrame;
    
    if ([self isEditing]) {
        routeFrame.origin.x = routeFrame.origin.x - 80;
        _route.frame = routeFrame;
        
        dateFrame.origin.x = dateFrame.origin.x - 80;
        _date.frame = dateFrame;
    }
    
    [super layoutSubviews];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
	[super setHighlighted:highlighted animated:animated];
	[_strength setNeedsDisplay];
	[_frequency setNeedsDisplay];
	[_route setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];
	[_strength setNeedsDisplay];
	[_frequency setNeedsDisplay];
	[_route setNeedsDisplay];
}


- (void)dealloc
{
    [_name release];
    [_date release];
    
    [_strength release];
    [_frequency release];
    [_route release];
    
    [super dealloc];
}

@end
