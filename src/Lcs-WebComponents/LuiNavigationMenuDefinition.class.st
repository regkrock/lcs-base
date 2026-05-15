Class {
	#name : 'LuiNavigationMenuDefinition',
	#superclass : 'LcsMenuDefinition',
	#instVars : [
		'menuComponentDefintions',
		'componentName'
	],
	#category : 'Lcs-WebComponents-Menus',
	#package : 'Lcs-WebComponents',
	#tag : 'Menus'
}

{ #category : 'example' }
LuiNavigationMenuDefinition class >> menuBarWithSubSubMenuDefinition [
	| menuDefinition |
	menuDefinition := LuiNavigationMenuDefinition new.
	menuDefinition
		addDefinition: (LcsSubmenuDefinition new
			label: 'Menu 1';
			addDefinition: (LuiMenuItemDefinition new label: 'Menu 1 Item 1');
			addDefinition: (LuiMenuItemDefinition new label: 'Menu 1 Item 2');
			addDefinition: (LuiMenuItemDefinition new label: 'Menu 1 Item 3'));
		addDefinition: (LcsSubmenuDefinition new
			label: 'Menu 2';
			addDefinition: (LuiMenuItemDefinition new label: 'Menu 2 Item 1');
			addDefinition: (LuiMenuItemDefinition new label: 'Menu 2 Item 2'));
		addDefinition: (LcsSubmenuDefinition new
			label: 'Menu 3';
			addDefinition: (LuiMenuItemDefinition new label: 'Menu 3 Item 1');
			addDefinition: (LcsSubmenuDefinition new
				label: 'Menu 3 Item 2';
				addDefinition: (LuiMenuItemDefinition new label: 'Menu 3 Item 2 Submenu Item 1');
				addDefinition: (LuiMenuItemDefinition new label: 'Menu 3 Item 2 Submenu Item 2'));
			addDefinition: (LcsSubmenuDefinition new
				label: 'Menu 3 Item 3';
				addDefinition: (LuiMenuItemDefinition new label: 'Menu 3 Item 3 Submenu Item 1');
				addDefinition: (LuiMenuItemDefinition new label: 'Menu 3 Item 3 Submenu Item 2'))).
	^ menuDefinition
]

{ #category : 'example' }
LuiNavigationMenuDefinition class >> menuBarWithSubmenuExample [
	<example>
	| bar |
	bar := LuiNavigationMenuDefinition new.
	bar 
		addDefinition: (LuiMenuItemDefinition new
				label: 'Home';
				yourself);
		addDefinition: (LcsSubmenuDefinition new
				label: 'Contacts';
				addDefinition: (LuiMenuItemDefinition new
					label: 'Phone';
					yourself);
				addDefinition: (LuiMenuItemDefinition new
					label: 'Address';
					yourself);
				yourself);
		addDefinition: (LuiMenuItemDefinition new
				label: 'About Us';
				yourself).
	^ bar
]

{ #category : 'example' }
LuiNavigationMenuDefinition class >> simpleMenuBarExample [
	<example>
	| bar |
	bar := LuiNavigationMenuDefinition new.
	bar 
		addDefinition: (LuiMenuItemDefinition new
				label: 'Home';
				yourself);
		addDefinition: (LuiMenuItemDefinition new
				label: 'About Us';
				yourself).
	^ bar
]

{ #category : 'menu groups' }
LuiNavigationMenuDefinition >> addDefinition: aMenuComponentDefintion [
	aMenuComponentDefintion parent: self.
	self menuComponentDefintions add: aMenuComponentDefintion
]

{ #category : 'components' }
LuiNavigationMenuDefinition >> buildNavigationMenuIn: aLuiComponent [
	self menuComponentDefintions do: [ :eachComponent | 
		| menuComponent |
		menuComponent := eachComponent componentClass named: eachComponent componentName.
		aLuiComponent addComponent: menuComponent.
		menuComponent buildFrom: eachComponent]
]

{ #category : 'accessing' }
LuiNavigationMenuDefinition >> componentName [
	^ componentName
]

{ #category : 'accessing' }
LuiNavigationMenuDefinition >> componentName: aString [
	componentName := aString
]

{ #category : 'as yet unclassified' }
LuiNavigationMenuDefinition >> gtMenuDefintionStructureViewFor: aView [
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

{ #category : 'initialize' }
LuiNavigationMenuDefinition >> initialize [
	super initialize.
	self menuComponentDefintions: OrderedCollection new
]

{ #category : 'accessing' }
LuiNavigationMenuDefinition >> menuComponentDefintions [
	^ menuComponentDefintions
]

{ #category : 'accessing' }
LuiNavigationMenuDefinition >> menuComponentDefintions: anObject [
	menuComponentDefintions := anObject
]
