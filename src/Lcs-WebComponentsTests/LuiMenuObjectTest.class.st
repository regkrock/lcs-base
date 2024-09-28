Class {
	#name : #LuiMenuObjectTest,
	#superclass : #TestCase,
	#category : #'Lcs-WebComponentsTests-Tests'
}

{ #category : #utilities }
LuiMenuObjectTest >> menuDefinition [
	| menuDefinition |
	menuDefinition := LcsMainMenuDefinition new.
	menuDefinition
		addGroup: (LcsMenuGroupDefinition new
				menuName: 'Who Are We';
				addMenuItem: (LcsMenuItemDefinition new menuName: 'Our Officers and Trustees');
				addMenuItem: (LcsMenuItemDefinition new menuName: 'Photos and Videos');
				addMenuItem: (LcsMenuItemDefinition new menuName: 'Policies, Manuals and Forms');
				addMenuItem: (LcsMenuItemDefinition new menuName: 'Contact Us');
				addMenuItem: (LcsMenuItemDefinition new menuName: 'Donations');
				addMenuItem: (LcsMenuItemDefinition new menuName: 'Members Section (requires login)'));
		addGroup: (LcsMenuGroupDefinition new
				menuName: 'Learn';
				addMenuItem: (LcsMenuItemDefinition new menuName: 'Basic Sailing');
				addMenuItem: (LcsMenuItemDefinition new menuName: 'Curising'));
		addGroup: (LcsMenuGroupDefinition new
				menuName: 'Policies, Manuals and Forms';
				addMenuItem: (LcsMenuItemDefinition new menuName: 'Contact Us');
				addMenuItem: (LcsMenuItemDefinition new
						menuName: 'Donations';
						submenu: (LcsMenuSubgroupDefinition new
								addMenuItem: (LcsMenuItemDefinition new menuName: 'Small Boat Donation');
								addMenuItem: (LcsMenuItemDefinition new menuName: 'Activity Sail Donation')));
				addMenuItem: (LcsMenuItemDefinition new menuName: 'Members Section (requires login)')).
	^ menuDefinition
]

{ #category : #test }
LuiMenuObjectTest >> testCreation [
	| mainMenuComponent groupMenuComponent menuItemComponent submenuComponent |
	mainMenuComponent := LuiMainMenu new.
	mainMenuComponent buildFrom: self menuDefinition.
	self assert: mainMenuComponent components size = 3.
		"==First Group=="
	groupMenuComponent := mainMenuComponent  firstComponent.
	self assert: groupMenuComponent name = 'Who Are We'.
	self assert: groupMenuComponent parentComponent == mainMenuComponent.
	
	menuItemComponent := groupMenuComponent firstComponent.
	self assert: menuItemComponent menuName = 'Our Officers and Trustees'.

	menuItemComponent := groupMenuComponent lastComponent.
	self assert: menuItemComponent menuName = 'Members Section (requires login)'.
	self assert: menuItemComponent components isEmpty.
	
	"==Third Group=="
	groupMenuComponent := mainMenuComponent componentAtIndex: 3.
	self assert: groupMenuComponent name = 'Policies, Manuals and Forms'.
	
	menuItemComponent := groupMenuComponent componentAtIndex: 2.
	self assert: menuItemComponent menuName = 'Donations'.
	self assert: menuItemComponent components size = 1.
	submenuComponent := menuItemComponent firstComponent.
	self assert: submenuComponent components size = 2.
	menuItemComponent := submenuComponent lastComponent.
	self assert: menuItemComponent components isEmpty.
	self assert: menuItemComponent menuName = 'Activity Sail Donation'


]
