Class {
	#name : 'LuiSEASRoot',
	#superclass : 'LuiRoot',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'initialize' }
LuiSEASRoot class >> initialize [
	(WAAdmin register: self asApplicationAt: 'seas')
		sessionClass: WAExpirySession
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
	| navBar navigationMenu homeMenuItem contactMenuItem aboutMenuItem header submenu contactMenuItemB contactSubMenuSubmenu |
	header := LuiPageHeader new.
	self addComponent: header.
	navBar := LuiNavigationBar named: 'navBar'.
	header addComponent: navBar.
	navBar addComponent: LuiImage seasMonmouthFavicon.
	navigationMenu := LuiMenu newMainMenu.
	navBar addComponent: navigationMenu.
	homeMenuItem := (LuiMenuItem named: 'homeMenuItem')
						label: 'Home';
						title: 'Home Menu Item';
						yourself.
	contactMenuItem := (LuiMenuItem named: 'contactMenuItem')
						label: 'Contact';
						title: 'Contact Menu Item';
						yourself.
	aboutMenuItem := (LuiMenuItem named: 'aboutMenuItem')
						label: 'About';
						title: 'About Menu Item';
						yourself.
	navigationMenu
		addComponent: homeMenuItem;
		addComponent: contactMenuItem;
		addComponent: aboutMenuItem.
	
	submenu := (LuiMenu newSubmenuNamed: 'contactSubMenu')
					cssClass: 'submenu';
					yourself.
	contactMenuItem addComponent: submenu.
	submenu
		addComponent:
			((LuiMenuItem named: 'contactMenuItemA')
				label: 'Contact A');
		addComponent: (
			contactMenuItemB := (LuiMenuItem named: 'contactMenuItemB')
				label: 'Contact B');
		addComponent: (
			(LuiMenuItem named: 'contactMenuItemC')
				label: 'Contact C').
				
	contactMenuItemB  addComponent: (contactSubMenuSubmenu := LuiMenu newSubmenuNamed: 'contactSubMenuSubmenu').
	contactSubMenuSubmenu
		addComponent: ((LuiMenuItem named: 'contactMenuItemA_A')
				label: 'Contact A Item A');
		addComponent: (
			contactMenuItemB := (LuiMenuItem named: 'contactMenuItemB_B')
				label: 'Contact B Item B')

]

{ #category : 'updating' }
LuiSEASRoot >> updateFilesInRoot: aRoot [ 
	super updateFilesInRoot: aRoot.
	aRoot stylesheet url: LcsFileLibrary / #resetCss.
	aRoot stylesheet url: LcsFileLibrary / #mainCss.
	aRoot link beShortcutIcon url: LcsFileLibrary / #faviconPng
]
