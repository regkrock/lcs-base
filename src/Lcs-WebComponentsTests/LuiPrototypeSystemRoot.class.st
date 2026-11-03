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
	| root |
	root := (self basicNew initializeWithHeaderWithNavBar)
		addComponent: ((LuiForm newWith: (LuiDomainPresenter named: 'abc'))
						cssClass: LuiCssClassesMap / #'mainForm';
						yourself);
		yourself.
	^ root
]

{ #category : 'menu item' }
LuiPrototypeSystemRoot >> aboutMenuItem [
	^ (LuiMenuItem named: 'aboutMenuItem')
		cssClass: LuiCssClassesMap / #'nav-item';
		anchorLabel: 'About';
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
		addCssClass: LuiCssClassesMap / #'has-submenu';
		addRightArrowToAnchorSpanComponent.
	subSubMenu := (LuiMenu newSubmenuNamed: 'contactSubMenuSubmenu').
	aMenuItem addComponent: subSubMenu.
	aMenuItems do: [ :each |subSubMenu addComponent: each ]
]

{ #category : 'menus' }
LuiPrototypeSystemRoot >> addSubmenuTo: aMenuItem [
	| submenu contactMenuItemB contactMenuItemA |
	aMenuItem addCssClass: LuiCssClassesMap / #'has-submenu'.
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
	| brandComponent  |
	brandComponent := LuiDiv named: 'brand'. 
	brandComponent
		cssClass: LuiCssClassesMap / #'brand';
		addComponent: LuiAnchor newSeasLogo;
		addComponent: ((LuiLabel named: 'brandName')
						text: 'SEAS Monmouth';
						yourself).
	^ brandComponent
]

{ #category : 'menu item' }
LuiPrototypeSystemRoot >> contactMenuItem [
	^ (LuiMenuItem named: 'contactMenuItem')
		cssClass: LuiCssClassesMap / #'nav-item';
		hiddenCheckbox: 'sub1';
		buttonLabel: 'Contact';
		"callback: [ Transcript
				cr;
				show: 'contactMenuItem clicked' ];"
		title: 'Contact Menu Item';
		yourself
]

{ #category : 'menu item' }
LuiPrototypeSystemRoot >> contactMenuItemA [
	^ (LuiMenuItem named: 'contactMenuItemA')
		cssClass: LuiCssClassesMap / #'nav-item';
		anchorLabel: 'Contact A';
		callback: [ Transcript
				cr;
				show: 'clicked Contact A' ];
		yourself
]

{ #category : 'menu item' }
LuiPrototypeSystemRoot >> contactMenuItemA_A [
	^ (LuiMenuItem named: 'contactMenuItemA_A')
		cssClass: LuiCssClassesMap / #'nav-item';
		anchorLabel: 'Contact A Item A';
		callback: [ Transcript
				cr;
				show: 'clicked Contact A Item A' ];
		yourself
]

{ #category : 'menu item' }
LuiPrototypeSystemRoot >> contactMenuItemA_B [
	^ (LuiMenuItem named: 'contactMenuItemA_B')
		cssClass: LuiCssClassesMap / #'nav-item';
		anchorLabel: 'Contact A Item B';
		callback: [ Transcript
				cr;
				show: 'clicked Contact A Item B' ];
		yourself
]

{ #category : 'menu item' }
LuiPrototypeSystemRoot >> contactMenuItemB [
	^ (LuiMenuItem named: 'contactMenuItemB')
		cssClass: LuiCssClassesMap / #'nav-item';
		anchorLabel: 'Contact B';
		callback: [ Transcript
				cr;
				show: 'clicked Contact B' ];
		yourself
]

{ #category : 'menu item' }
LuiPrototypeSystemRoot >> contactMenuItemB_A [
	^ (LuiMenuItem named: 'contactMenuItemB_A')
		cssClass: LuiCssClassesMap / #'nav-item';
		anchorLabel: 'Contact B Item A';
		callback: [ Transcript
				cr;
				show: 'clicked Contact B Item A' ];
		yourself
]

{ #category : 'menu item' }
LuiPrototypeSystemRoot >> contactMenuItemC [
	^ (LuiMenuItem named: 'contactMenuItemC')
		cssClass: LuiCssClassesMap / #'nav-item';
		anchorLabel: 'Contact C';
		callback: [ Transcript
				cr;
				show: 'clicked Contact C' ];
		yourself
]

{ #category : 'menu item' }
LuiPrototypeSystemRoot >> contactSubMenu [
	^ (LuiMenu newSubmenuNamed: 'contactSubMenu')
		cssClass: LuiCssClassesMap / #'submenu';
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
		cssClass: LuiCssClassesMap / #'hamburger';
		text: '';
		addComponent: (LuiSpan named: 'span1');
		addComponent: (LuiSpan named: 'span2');
		addComponent: (LuiSpan named: 'span3');
		yourself
]

{ #category : 'components' }
LuiPrototypeSystemRoot >> hiddenCheckboxComponent [
	^ (LuiResponsiveNavigationMenuCheckbox named: 'menuToggle')
		assignStaticId: 'menu-toggle';
		yourself
]

{ #category : 'menu item' }
LuiPrototypeSystemRoot >> homeMenuItem [
	^ (LuiMenuItem named: 'homeMenuItem')
		cssClass: LuiCssClassesMap / #'nav-item';
		anchorLabel: 'Home';
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
		cssClass: LuiCssClassesMap / #'nav-menu';
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
		cssClass: LuiCssClassesMap / #'nav-container';
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
		cssClass: LuiCssClassesMap / #'topHeader';
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
