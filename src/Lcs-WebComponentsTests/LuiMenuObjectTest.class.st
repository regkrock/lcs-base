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
		addMenuComponentDefintion: (LcsSubmenuDefinition new
				menuItemLabel: 'Who Are We';
				addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Our Officers and Trustees');
				addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Photos and Videos');
				addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Policies, Manuals and Forms');
				addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Contact Us');
				addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Donations');
				addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Members Section (requires login)'));
		addMenuComponentDefintion: (LcsSubmenuDefinition new
				menuItemLabel: 'Learn';
				addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Basic Sailing');
				addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Curising'));
		addMenuComponentDefintion: (LcsSubmenuDefinition new
				menuItemLabel: 'Policies, Manuals and Forms';
				addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Contact Us');
				addMenuComponentDefintion: (LcsMenuItemDefinition new
						menuItemLabel: 'Donations';
						submenu: (LcsSubmenuDefinition new
								addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Small Boat Donation');
								addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Activity Sail Donation')));
				addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Members Section (requires login)')).
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
	self assert: menuItemComponent menuItemLabel = 'Our Officers and Trustees'.

	menuItemComponent := groupMenuComponent lastComponent.
	self assert: menuItemComponent menuItemLabel = 'Members Section (requires login)'.
	self assert: menuItemComponent components isEmpty.
	
	"==Third Group=="
	groupMenuComponent := mainMenuComponent componentAtIndex: 3.
	self assert: groupMenuComponent name = 'Policies, Manuals and Forms'.
	
	menuItemComponent := groupMenuComponent componentAtIndex: 2.
	self assert: menuItemComponent menuItemLabel = 'Donations'.
	self assert: menuItemComponent components size = 1.
	submenuComponent := menuItemComponent firstComponent.
	self assert: submenuComponent components size = 2.
	menuItemComponent := submenuComponent lastComponent.
	self assert: menuItemComponent components isEmpty.
	self assert: menuItemComponent menuItemLabel = 'Activity Sail Donation'


]
