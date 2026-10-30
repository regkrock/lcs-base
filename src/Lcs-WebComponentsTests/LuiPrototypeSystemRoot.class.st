Class {
	#name : 'LuiPrototypeSystemRoot',
	#superclass : 'LuiRoot',
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
	^ self newWithHeaderWithNavBar
]

{ #category : 'instance creation' }
LuiPrototypeSystemRoot class >> newWithComponent: aComponent [
	^ self basicNew 
		initializeWithComponent: aComponent;
		yourself
]

{ #category : 'instance creation' }
LuiPrototypeSystemRoot class >> newWithHeaderWithNavBar [
	^ (self basicNew initializeWithHeaderWithNavBar)
		addComponent: ((LuiForm newWith: (LuiDomainPresenter named: 'abc'))
						cssClass: 'mainForm';
						yourself);
		yourself
]

{ #category : 'menu item' }
LuiPrototypeSystemRoot >> aboutMenuItem [
	^ (LuiMenuItem named: 'aboutMenuItem')
		anchorLabel: 'About';
		removeAllCssClasses;
		callback: [ Transcript
				cr;
				show: 'aboutMenuItem clicked' ];
		"onClick: 'console.log(clicked About)';"
		title: 'About Menu Item';
		yourself	
]

{ #category : 'menus' }
LuiPrototypeSystemRoot >> addSubMenuItems: aMenuItems to: aMenuItem [
	| subSubMenu |
	aMenuItem 
		cssClass: 'has-submenu';
		addRightArrowToAnchorSpanComponent.
	subSubMenu := (LuiMenu newSubmenuNamed: 'contactSubMenuSubmenu').
	aMenuItem addComponent: subSubMenu.
	aMenuItems do: [ :each |subSubMenu addComponent: each ]
]

{ #category : 'menus' }
LuiPrototypeSystemRoot >> addSubmenuTo: aMenuItem [
	| submenu contactMenuItemB contactMenuItemA |
	aMenuItem cssClass: 'has-submenu'.
	aMenuItem addDownArrowToAnchorSpanComponent.
	aMenuItem addComponent: (submenu := self contactSubMenu).
	submenu
		addComponent: (contactMenuItemA := self contactMenuItemA);
		addComponent: (contactMenuItemB := self contactMenuItemB);
		addComponent: self contactMenuItemC.
	self addSubMenuItems: {self contactMenuItemA_A. self contactMenuItemA_B} to: contactMenuItemA.
	self addSubMenuItems: {self contactMenuItemB_A} to: contactMenuItemB
]

{ #category : 'setup' }
LuiPrototypeSystemRoot >> applicationTitle [
	^ 'Prototype System'
]

{ #category : 'menus' }
LuiPrototypeSystemRoot >> brandComponent [
	| brandComponent  contactMenuItem |
	brandComponent := LuiDiv named: 'brand'. 
	brandComponent
		cssClass: 'brand';
		addComponent: LuiAnchor newSeasLogo;
		addComponent: ((LuiLabel named: 'brandName')
						text: 'SEAS Monmouth';
						yourself).
	^ brandComponent
]

{ #category : 'menu item' }
LuiPrototypeSystemRoot >> contactMenuItem [
	^ (LuiMenuItem named: 'contactMenuItem')
		anchorLabel: 'Contact';
		callback: [ Transcript
				cr;
				show: 'contactMenuItem clicked' ];
		title: 'Contact Menu Item';
		yourself
]

{ #category : 'menu item' }
LuiPrototypeSystemRoot >> contactMenuItemA [
	^ (LuiMenuItem named: 'contactMenuItemA')
		removeAllCssClasses;
		anchorLabel: 'Contact A';
		callback: [ Transcript
				cr;
				show: 'clicked Contact A' ];
		yourself
]

{ #category : 'menu item' }
LuiPrototypeSystemRoot >> contactMenuItemA_A [
	^ (LuiMenuItem named: 'contactMenuItemA_A')
		removeAllCssClasses;
		anchorLabel: 'Contact A Item A';
		callback: [ Transcript
				cr;
				show: 'clicked Contact A Item A' ];
		yourself
]

{ #category : 'menu item' }
LuiPrototypeSystemRoot >> contactMenuItemA_B [
	^ (LuiMenuItem named: 'contactMenuItemA_B')
		removeAllCssClasses;
		anchorLabel: 'Contact A Item B';
		callback: [ Transcript
				cr;
				show: 'clicked Contact A Item B' ];
		yourself
]

{ #category : 'menu item' }
LuiPrototypeSystemRoot >> contactMenuItemB [
	^ (LuiMenuItem named: 'contactMenuItemB')
		removeAllCssClasses;
		anchorLabel: 'Contact B';
		callback: [ Transcript
				cr;
				show: 'clicked Contact B' ];
		yourself
]

{ #category : 'menu item' }
LuiPrototypeSystemRoot >> contactMenuItemB_A [
	^ (LuiMenuItem named: 'contactMenuItemB_A')
		removeAllCssClasses;
		anchorLabel: 'Contact B Item A';
		callback: [ Transcript
				cr;
				show: 'clicked Contact B Item A' ];
		yourself
]

{ #category : 'menu item' }
LuiPrototypeSystemRoot >> contactMenuItemC [
	^ (LuiMenuItem named: 'contactMenuItemC')
		removeAllCssClasses;
		anchorLabel: 'Contact C';
		callback: [ Transcript
				cr;
				show: 'clicked Contact C' ];
		yourself
]

{ #category : 'menu item' }
LuiPrototypeSystemRoot >> contactSubMenu [
	^ (LuiMenu newSubmenuNamed: 'contactSubMenu')
		cssClass: 'submenu';
		yourself
]

{ #category : 'setup' }
LuiPrototypeSystemRoot >> generatedId [
	^ 'root'
]

{ #category : 'components' }
LuiPrototypeSystemRoot >> hamburgerMenuComponent [
	"The spans are here to ensure there is space to display the hamburger"
	^ (LuiLabel named: 'menuToggleLabel')
		for: 'menu-toggle';
		cssClass: 'hamburger';
		text: '';
		addComponent: (LuiSpan named: 'span1');
		addComponent: (LuiSpan named: 'span2');
		addComponent: (LuiSpan named: 'span3');
		yourself
]

{ #category : 'components' }
LuiPrototypeSystemRoot >> hiddenCheckboxComponent [
	^ (LuiResponsiveNavigationMenuCheckbox named: 'menuToggle')
		cssClass: 'menu-toggle-checkbox';
		assignStaticId: 'menu-toggle';
		text: '';
		yourself
]

{ #category : 'menu item' }
LuiPrototypeSystemRoot >> homeMenuItem [
	^ (LuiMenuItem named: 'homeMenuItem')
		anchorLabel: 'Home';
		removeAllCssClasses;
		callback: [ Transcript
				cr;
				show: 'homeMenuItem clicked' ];
		title: 'Home Menu Item';
		yourself
]

{ #category : 'initialize' }
LuiPrototypeSystemRoot >> initialize [
	LcsApplicationEnvironment ensureCurrentSystemIsPrototypeSystem.
	super initialize
]

{ #category : 'initialize' }
LuiPrototypeSystemRoot >> initializeWithComponent: aComponent [
	self initialize.
	self addComponent: aComponent
]

{ #category : 'initialize' }
LuiPrototypeSystemRoot >> initializeWithHeaderWithNavBar [
	self initialize.
	self addComponent: self prototypeHeader.
]

{ #category : 'menus' }
LuiPrototypeSystemRoot >> mainNavigationMenu [
	| mainMenu  contactMenuItem |
	mainMenu := LuiMainMenu newMainMenu. 
	mainMenu
		cssClass: 'nav-menu';
		addComponent: self homeMenuItem;
		addComponent: (contactMenuItem := self contactMenuItem);
		addComponent: self aboutMenuItem;
		addComponent: self socialMediaBar.
	self addSubmenuTo: contactMenuItem.
	^ mainMenu
]

{ #category : 'menus' }
LuiPrototypeSystemRoot >> navContainerDiv [
	^ LuiDiv new
		componentName: 'navContainer';
		cssClass: 'nav-container';
		yourself
]

{ #category : 'menus' }
LuiPrototypeSystemRoot >> navigationBar [
	| navBar navContainer |
	navBar := LuiNavigationBar named: 'navbar'.
	navContainer := navBar addComponent: self navContainerDiv.
	navContainer
		addComponent: self brandComponent;
		addComponent: self hiddenCheckboxComponent;
		addComponent: self hamburgerMenuComponent;
		addComponent: self mainNavigationMenu.
	^ navBar
]

{ #category : 'components' }
LuiPrototypeSystemRoot >> prototypeHeader [
	| header |
	header := LuiPageHeader named: 'pageHeader'.
	header
		cssClass: 'topHeader';
		addComponent: self navigationBar.
	^ header
]

{ #category : 'callbacks' }
LuiPrototypeSystemRoot >> showCallbackOnTranscript [
	Transcript
		cr;
		show: 'ok clicked';
		cr
]

{ #category : 'components' }
LuiPrototypeSystemRoot >> socialMediaBar [
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
