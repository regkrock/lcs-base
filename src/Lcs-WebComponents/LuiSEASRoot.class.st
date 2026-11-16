Class {
	#name : 'LuiSEASRoot',
	#superclass : 'LuiApplicationRoot',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'initialize' }
LuiSEASRoot class >> initialize [
	self registerApplication: 'seas'
]

{ #category : 'constants' }
LuiSEASRoot >> applicationTitle [
	^ 'SEAS Monmouth'
]

{ #category : 'initialize' }
LuiSEASRoot >> initialize [
	super initialize.
	self initializeStandardLayout
]

{ #category : 'instance creation' }
LuiSEASRoot >> initializeStandardLayout [
	| navigationBar navigationMenu homeMenuItem contactMenuItem aboutMenuItem header submenu contactMenuItemB contactSubMenuSubmenu |
	header := LuiPageHeader new.
	self addComponent: header.
	navigationBar := LuiNavigationBar new.
	header addComponent: navigationBar.
	navigationBar addComponent: LuiImage seasMonmouthFavicon.
	navigationMenu := LuiNavigationMenu new.
	navigationBar addComponent: navigationMenu.
	homeMenuItem := (LuiMenuItem named: 'homeMenuItem')
						buttonLabel: 'Home';
						title: 'Home Menu Item';
						yourself.
	contactMenuItem := (LuiMenuItem named: 'contactMenuItem')
						buttonLabel: 'Contact';
						title: 'Contact Menu Item';
						yourself.
	aboutMenuItem := (LuiMenuItem named: 'aboutMenuItem')
						buttonLabel: 'About';
						title: 'About Menu Item';
						yourself.
	navigationMenu
		addComponent: homeMenuItem;
		addComponent: contactMenuItem;
		addComponent: aboutMenuItem.
	
	submenu := (LuiMenu newSubmenuNamed: 'contactSubMenu')
					cssClass: LuiCssClassesMap / #'submenu';
					yourself.
	contactMenuItem addComponent: submenu.
	submenu
		addComponent:
			((LuiMenuItem named: 'contactMenuItemA')
				buttonLabel: 'Contact A');
		addComponent: (
			contactMenuItemB := (LuiMenuItem named: 'contactMenuItemB')
				buttonLabel: 'Contact B');
		addComponent: (
			(LuiMenuItem named: 'contactMenuItemC')
				buttonLabel: 'Contact C').
				
	contactMenuItemB  addComponent: (contactSubMenuSubmenu := LuiMenu newSubmenuNamed: 'contactSubMenuSubmenu').
	contactSubMenuSubmenu
		addComponent: ((LuiMenuItem named: 'contactMenuItemA_A')
				buttonLabel: 'Contact A Item A');
		addComponent: (
			contactMenuItemB := (LuiMenuItem named: 'contactMenuItemB_B')
				buttonLabel: 'Contact B Item B')

]

{ #category : 'updating' }
LuiSEASRoot >> updateFilesInRoot: aRoot [ 
	| fileClass |
	fileClass := LcsFileLibrary.
	super updateFilesInRoot: aRoot.
	aRoot stylesheet url: fileClass / #resetCss.
	aRoot stylesheet url: fileClass / #mainCss.
	aRoot link beShortcutIcon url: fileClass / #faviconPng
]
