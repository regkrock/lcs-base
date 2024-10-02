Class {
	#name : #LcsMainMenuDefinition,
	#superclass : #LcsMenuDefinition,
	#instVars : [
		'menuComponentName',
		'menuComponentDefintions'
	],
	#category : #'Lcs-WebComponents-Menus'
}

{ #category : #example }
LcsMainMenuDefinition class >> menuBarWithSubSubMenuDefinition [
	| menuDefinition |
	menuDefinition := LcsMainMenuDefinition new.
	menuDefinition
		addMenuComponentDefintion: (LcsSubmenuDefinition new
			menuItemLabel: 'Menu 1';
			addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Menu 1 Item 1');
			addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Menu 1 Item 2');
			addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Menu 1 Item 3'));
		addMenuComponentDefintion: (LcsSubmenuDefinition new
			menuItemLabel: 'Menu 2';
			addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Menu 2 Item 1');
			addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Menu 2 Item 2'));
		addMenuComponentDefintion: (LcsSubmenuDefinition new
			menuItemLabel: 'Menu 3';
			addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Menu 3 Item 1');
			addMenuComponentDefintion: (LcsSubmenuDefinition new
				menuItemLabel: 'Menu 3 Item 2';
				addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Menu 3 Item 2 Submenu Item 1');
				addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Menu 3 Item 2 Submenu Item 2'));
			addMenuComponentDefintion: (LcsSubmenuDefinition new
				menuItemLabel: 'Menu 3 Item 3';
				addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Menu 3 Item 3 Submenu Item 1');
				addMenuComponentDefintion: (LcsMenuItemDefinition new menuItemLabel: 'Menu 3 Item 3 Submenu Item 2'))).
	^ menuDefinition
]

{ #category : #example }
LcsMainMenuDefinition class >> menuBarWithSubmenuExample [
	<example>
	| bar |
	bar := LcsMainMenuDefinition new.
	bar 
		addMenuComponentDefintion: (LcsMenuItemDefinition new
				menuItemLabel: 'Home';
				yourself);
		addMenuComponentDefintion: (LcsSubmenuDefinition new
				menuItemLabel: 'Contacts';
				addMenuComponentDefintion: (LcsMenuItemDefinition new
					menuItemLabel: 'Phone';
					yourself);
				addMenuComponentDefintion: (LcsMenuItemDefinition new
					menuItemLabel: 'Address';
					yourself);
				yourself);
		addMenuComponentDefintion: (LcsMenuItemDefinition new
				menuItemLabel: 'About Us';
				yourself).
	^ bar
]

{ #category : #example }
LcsMainMenuDefinition class >> simpleMenuBarExample [
	<example>
	| bar |
	bar := LcsMainMenuDefinition new.
	bar 
		addMenuComponentDefintion: (LcsMenuItemDefinition new
				menuItemLabel: 'Home';
				yourself);
		addMenuComponentDefintion: (LcsMenuItemDefinition new
				menuItemLabel: 'About Us';
				yourself).
	^ bar
]

{ #category : #'menu groups' }
LcsMainMenuDefinition >> addMenuComponentDefintion: aMenuComponentDefintion [
	aMenuComponentDefintion parent: self.
	self menuComponentDefintions add: aMenuComponentDefintion
]

{ #category : #asking }
LcsMainMenuDefinition >> componentName [
	^ self menuItemLabel
]

{ #category : #'as yet unclassified' }
LcsMainMenuDefinition >> gtMenuDefintionStructureViewFor: aView [
	"<gtView>"

	^ aView columnedTree
		title: 'Menu Defintion';
		priority: 30;
		items: [ { self } ];
		children: [ self menuComponentDefintions ];
		column: 'Component Name' text: self componentName;
		column: 'Label' text: [ :item | self perform: item ];
		"send: [ :item | self perform: item ];"
		actionUpdateButton
]

{ #category : #initialize }
LcsMainMenuDefinition >> initialize [
	super initialize.
	self menuComponentDefintions: OrderedCollection new
]

{ #category : #accessing }
LcsMainMenuDefinition >> menuComponentDefintions [
	^ menuComponentDefintions
]

{ #category : #accessing }
LcsMainMenuDefinition >> menuComponentDefintions: anObject [
	menuComponentDefintions := anObject
]

{ #category : #accessing }
LcsMainMenuDefinition >> menuComponentName [
	^ menuComponentName 
]

{ #category : #accessing }
LcsMainMenuDefinition >> menuComponentName: anObject [
	menuComponentName := anObject
]
