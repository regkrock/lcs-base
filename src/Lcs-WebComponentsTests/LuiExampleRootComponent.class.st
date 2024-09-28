Class {
	#name : #LuiExampleRootComponent,
	#superclass : #LuiComponent,
	#category : #'Lcs-WebComponentsTests-Base'
}

{ #category : #initialize }
LuiExampleRootComponent class >> initialize [
	WAAdmin register: self asApplicationAt: 'example'
]

{ #category : #'as yet unclassified' }
LuiExampleRootComponent >> addMainNavigationMenuTo: aComponent [
	| menuBarComponent |
	menuBarComponent := LuiMainMenu named: 'navigation' on: aComponent.
	aComponent addComponent: menuBarComponent.
	menuBarComponent buildFrom: self menuDefinition
]

{ #category : #'as yet unclassified' }
LuiExampleRootComponent >> initialize [
	super initialize.
	self addComponent: (LuiExampleMainPage named: 'root' on: self).
	self addMainNavigationMenuTo: self lastComponent
]

{ #category : #'as yet unclassified' }
LuiExampleRootComponent >> menuDefinition [
	| menuDefinition |
	menuDefinition := LcsMainMenuDefinition new.
	menuDefinition
		addGroup: (LcsMenuGroupDefinition new
				menuName: 'Menu 1';
				addMenuItem: (LcsMenuItemDefinition new menuName: 'Menu 1 Item 1');
				addMenuItem: (LcsMenuItemDefinition new menuName: 'Menu 1 Item 2');
				addMenuItem: (LcsMenuItemDefinition new menuName: 'Menu 1 Item 3'));
		addGroup: (LcsMenuGroupDefinition new
				menuName: 'Menu 2';
				addMenuItem: (LcsMenuItemDefinition new menuName: 'Menu 2 Item 1');
				addMenuItem: (LcsMenuItemDefinition new menuName: 'Menu 2 Item 2'));
		addGroup: (LcsMenuGroupDefinition new
				menuName: 'Menu 3';
				addMenuItem: (LcsMenuItemDefinition new menuName: 'Contact Us');
				addMenuItem: (LcsMenuItemDefinition new
						menuName: 'Menu 3 Item 2';
						submenu: (LcsMenuSubgroupDefinition new
								addMenuItem: (LcsMenuItemDefinition new menuName: 'Menu 3 2 Item 1');
								addMenuItem: (LcsMenuItemDefinition new menuName: 'Menu 3 2 Item 2')));
				addMenuItem: (LcsMenuItemDefinition new menuName: 'Menu 3 3 Item')).
	^ menuDefinition
]

{ #category : #rendering }
LuiExampleRootComponent >> renderComponentOn: html [
	html div 
		with: [
			html heading
				level: 1;
				with: 'Example System'.
			html break.
			self renderSubcomponentsOn: html ]
]

{ #category : #'as yet unclassified' }
LuiExampleRootComponent >> updateRoot: aRoot [

	super updateRoot: aRoot.
	aRoot title: 'Seaside Example'.
	aRoot stylesheet url: WAFileLibrary / #mainCss
]
