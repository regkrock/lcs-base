Class {
	#name : 'LuiPrototypeSystemRoot',
	#superclass : 'LuiApplicationRoot',
	#category : 'Lcs-WebComponentsTests-Base',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Base'
}

{ #category : 'initialize' }
LuiPrototypeSystemRoot class >> initialize [
	self registerApplication: 'prototypeSystem'
]

{ #category : 'instance creation' }
LuiPrototypeSystemRoot class >> new [
	| systemApplicationRoot |
	systemApplicationRoot := super new.
	^ systemApplicationRoot
]

{ #category : 'components - definition' }
LuiPrototypeSystemRoot >> aboutContactItemDefinition [
	^ (LuiMenuItem named: 'contactMenuItem')
		cssClass: LuiCssClassesMap / #'nav-item';
		anchorLabel: 'Contact';
		callback: [ 
			Transcript cr; show: 'contactMenuItem clicked'.
			self rootComponent mainForm switchToComponent: (
				LuiMessagePresenter new
					componentName: 'contactPresenter';
						message: 'Contact';
						yourself) ];
		title: 'Contact Menu Item';
		yourself
]

{ #category : 'defaults' }
LuiPrototypeSystemRoot >> applicationTitle [
	^ 'Prototype System'
]

{ #category : 'components - definition' }
LuiPrototypeSystemRoot >> contactSubenuComponentDefinition [
	^((LuiDropDownMenuItem named: 'company' label: 'Company')
				cssClass: 'nav-item';
				yourself)
		addMenuItem: (
			(LuiMenuItem named: 'aboutUs')
				anchorLabel: 'About Us';
				cssClass: LuiCssClassesMap / #'submenu-item';
				callback: [ Transcript
					cr;
					show: 'aboutUs clicked'.
					self rootComponent mainForm switchToComponent: (
							LuiMessagePresenter new 
								componentName: 'aboutUsPresenter';
								message: 'Company ... About Us';
								yourself) ];
				yourself);
		addMenuItem: (
			(LuiMenuItem named: 'careers')
				anchorLabel: 'Careers';
				cssClass: LuiCssClassesMap / #'submenu-item';
				callback: [ Transcript
					cr;
					show: 'careers clicked'.
					self rootComponent mainForm switchToComponent: (
							LuiMessagePresenter new 
								componentName: 'careersPresenter';
								message: 'Company ... Careers';
								yourself) ];
				yourself);
		addMenuItem: (
			(LuiMenuItem named: 'ourTeam')
				anchorLabel: 'Our Team';
				cssClass: LuiCssClassesMap / #'submenu-item';
				callback: [ Transcript
					cr;
					show: 'our team clicked'.
					self rootComponent mainForm switchToComponent: (
							LuiMessagePresenter new 
								componentName: 'ourteamPresenter';
								message: 'Company ... Our Team';
								yourself) ];
				yourself);
		yourself
]

{ #category : 'defaults' }
LuiPrototypeSystemRoot >> generatedId [
	^ 'root'
]

{ #category : 'components - definition' }
LuiPrototypeSystemRoot >> homeMenuItemComponentDefinition [
	^ (LuiMenuItem named: 'homeMenuItem')
		cssClass: LuiCssClassesMap / #'nav-item';
		anchorLabel: 'Home';
		callback: [ 
			Transcript
				cr;
				show: 'homeMenuItem clicked'.
				self rootComponent mainForm switchToComponent: (LuiHomePresenter new) ];
		title: 'Home Menu Item';
		yourself
]

{ #category : 'initialize' }
LuiPrototypeSystemRoot >> initialize [
	LcsApplicationEnvironment ensureCurrentSystemIsPrototypeSystem.
	super initialize.
	self initializeStandardPageLayout
]

{ #category : 'initialize' }
LuiPrototypeSystemRoot >> initializeStandardPageLayout [
	self addComponent: self pageHeaderComponentDefinition.
	self addComponent: self mainFormComponentDefinition
]

{ #category : 'components - querying' }
LuiPrototypeSystemRoot >> mainForm [
	^ self componentNamed: 'mainForm'
]

{ #category : 'components - definition' }
LuiPrototypeSystemRoot >> mainFormComponentDefinition [
	^ LuiMainForm new
		switchToComponent: LuiHomePresenter new;
		yourself
]

{ #category : 'components - definition' }
LuiPrototypeSystemRoot >> navBarComponentDefinition [
	| navbar |
	navbar := LuiNavigationBar new.
	navbar
		addComponent: LuiBrand newSeasBrand;
		addComponent: ((LuiResponsiveNavigationMenuCheckbox named: 'menuToggle')
				assignStaticId: 'menu-toggle';
				yourself);
		addComponent: ((LuiLabel named: 'menuToggleLabel')
				for: 'menu-toggle';
				cssClass: 'menu-btn';
				text: self class hamburgerCodePointString;
				yourself);
		addComponent: (LuiMainMenu new
				addComponent: self homeMenuItemComponentDefinition;
				addComponent: self contactSubenuComponentDefinition;
				addComponent: self aboutContactItemDefinition;
				addComponent: self socialMediaBarComponentDefinition;
				yourself).
	^ navbar
]

{ #category : 'components - querying' }
LuiPrototypeSystemRoot >> pageHeader [
	^ self componentNamed: 'pageHeader'
]

{ #category : 'components - definition' }
LuiPrototypeSystemRoot >> pageHeaderComponentDefinition [
	| pageHeader |
	pageHeader := LuiPageHeader new.
	pageHeader addComponent: self navBarComponentDefinition.
	^ pageHeader
]

{ #category : 'components - definition' }
LuiPrototypeSystemRoot >> socialMediaBarComponentDefinition [
	^ LuiSearchAndSocialMediaBar newSearchAndLinks
]

{ #category : 'updating' }
LuiPrototypeSystemRoot >> updateFilesInRoot: anHtmlRoot [
	| fileClass |
	fileClass := LcsPrototypeFileLibrary.
	super updateFilesInRoot: anHtmlRoot.
	anHtmlRoot stylesheet url: fileClass / #resetCss.
	anHtmlRoot stylesheet url: fileClass / #mainCss.
	"anHtmlRoot stylesheet url: fileClass / #navigationMenuCss.
	anHtmlRoot stylesheet url: fileClass / #socialMediaCss."
	anHtmlRoot link beShortcutIcon url: fileClass / #faviconPng
]
