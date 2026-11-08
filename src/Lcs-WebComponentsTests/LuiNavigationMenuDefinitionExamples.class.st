Class {
	#name : 'LuiNavigationMenuDefinitionExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiNavigationMenuDefinitionExamples >> navigationMenuDefinition [
	<gtExample>
	| menuDefinition |
	menuDefinition := self newDefinition.
	menuDefinition componentName: 'navigationMenu'.
	self assert: menuDefinition componentName = 'navigationMenu'.
	^ menuDefinition
]

{ #category : 'examples' }
LuiNavigationMenuDefinitionExamples >> navigationMenuWith3Submenus [
	<gtExample>
	| menuDefinition |
	menuDefinition := self navigationMenuDefinition.
	menuDefinition addDefinition: (LuiSubmenuDefinitionExamples new menu1DefinitionWith3Submenus).
	menuDefinition addDefinition: (LuiSubmenuDefinitionExamples new menu2DefinitionWith2Submenus).
	menuDefinition addDefinition: (LuiSubmenuDefinitionExamples new menu3Definition3SubmenuLevels).
	^ menuDefinition
]

{ #category : 'examples' }
LuiNavigationMenuDefinitionExamples >> navigationMenuWithThreeMenuItemDefinitions [
	<gtExample>
	| menuDefinition |
	menuDefinition := self navigationMenuDefinition.
	menuDefinition
		addDefinition: (
			LuiMenuItemDefinition new 
				label: 'Home';
				title: 'Go to Home';
				yourself);
		addDefinition: (LuiMenuItemDefinition new label: 'Contact');
		addDefinition: (LuiMenuItemDefinition new label: 'About').
	^ menuDefinition
]

{ #category : 'examples' }
LuiNavigationMenuDefinitionExamples >> newDefinition [
	<gtExample>
	| menuDefinition |
	menuDefinition := LuiNavigationMenuDefinition new.
	self assert: menuDefinition cssClasses isEmpty.
	self assert: menuDefinition menuComponentDefintions isEmpty.
	self assert: menuDefinition componentName isNil.
	self assert: menuDefinition parent isNil.
	^ menuDefinition
]

{ #category : 'examples' }
LuiNavigationMenuDefinitionExamples >> softwareCompanyNavbarMainMenuDefinition [
	<gtExample>
	| menuDefinition |
	menuDefinition := self navigationMenuDefinition.
	menuDefinition addDefinition: (LuiMenuItemDefinition new label: 'Home'; url: '#').
	menuDefinition addDefinition: (
		(LcsSubmenuDefinition new label: 'Services')
			addDefinition: (LuiMenuItemDefinition new label: 'Web Design'; url: '#');
			addDefinition: ((LcsSubmenuDefinition new label: 'Development')
								addDefinition: (LuiMenuItemDefinition new label: 'Frontend Code'; url: '#');
								addDefinition: (LuiMenuItemDefinition new label: 'Backend Logic'; url: '#');
								addDefinition: (LuiMenuItemDefinition new label: 'Mobile Apps'; url: '#');
								yourself);
			addDefinition: (LuiMenuItemDefinition new label: 'SEO Marketing'; url: '#');
			yourself).
	menuDefinition addDefinition: (
		(LcsSubmenuDefinition new label: 'Company')
			addDefinition: (LuiMenuItemDefinition new label: 'About Us'; url: '#');
			addDefinition: (LuiMenuItemDefinition new label: 'Our Team'; url: '#');
			addDefinition: (LuiMenuItemDefinition new label: 'Carrers'; url: '#');
			yourself).
	menuDefinition addDefinition: (LuiMenuItemDefinition new label: 'Contact'; url: '#').
	^ menuDefinition
]

{ #category : 'examples' }
LuiNavigationMenuDefinitionExamples >> softwareCompanyNavbarMainMenuFromHandCodedStructure [
	"This is a manually created menu which should be the same as #softwareCompanyNavbarMainMenu that uses the definition to generate the menu"
	<gtExample>
	^ (LuiMainMenu named: 'mainMenu')
		addComponent: ((LuiMenuItem named: 'home')
				anchorHref: '#';
				anchorLabel: 'Home';
				yourself);
		addComponent: (
			((LuiDropDownMenuItem named: 'services' label: 'Services')
					cssClass: 'nav-item';
					yourself)
				addMenuItem: ((LuiMenuItem named: 'webDesign')
						anchorHref: '#';
						anchorLabel: 'Web Design';
						cssClass: LuiCssClassesMap / #'submenu-item');
				addMenuItem: (((LuiDropDownMenuItem named: 'development' label: 'Development')
					cssClass: LuiCssClassesMap / #'submenu-item')
						addMenuItem: ((LuiMenuItem named: 'frontEnd')
								anchorHref: '#';
								anchorLabel: 'Frontend Code';
								cssClass: LuiCssClassesMap / #'submenu-item';
								yourself);
						addMenuItem: ((LuiMenuItem named: 'backend')
								anchorHref: '#';
								anchorLabel: 'Backend Logic';
								cssClass: LuiCssClassesMap / #'submenu-item';
								yourself);
						addMenuItem: ((LuiMenuItem named: 'mobile')
								anchorHref: '#';
								anchorLabel: 'Mobile Apps';
								cssClass: LuiCssClassesMap / #'submenu-item';
								yourself));
				addMenuItem: ((LuiMenuItem named: 'seoMarketing')
						anchorHref: '#';
						anchorLabel: 'SEO Marketing';
						cssClass: LuiCssClassesMap / #'submenu-item');
				yourself);
		addComponent: (((LuiDropDownMenuItem named: 'company' label: 'Company')
									cssClass: 'nav-item';
									yourself)
				addMenuItem: ((LuiMenuItem named: 'aboutUs')
						anchorHref: '#';
						anchorLabel: 'About Us';
						cssClass: LuiCssClassesMap / #'submenu-item');
				addMenuItem: ((LuiMenuItem named: 'ourTeam')
						anchorHref: '#';
						anchorLabel: 'Our Team';
						cssClass: LuiCssClassesMap / #'submenu-item');
				addMenuItem: ((LuiMenuItem named: 'carrers')
						anchorHref: '#';
						anchorLabel: 'Carrers';
						cssClass: LuiCssClassesMap / #'submenu-item');
				yourself);
		addComponent: ((LuiMenuItem named: 'contact')
				anchorHref: '#';
				anchorLabel: 'Contact';
				yourself);
		yourself
]

{ #category : 'examples' }
LuiNavigationMenuDefinitionExamples >> softwareCompanyNavbarMainMenuFromMenuDefinition [
	<gtExample>
	| menuDefinition menu menuItem submenu developmentSubmenu|
	menuDefinition := self softwareCompanyNavbarMainMenuDefinition.
	menu := menuDefinition asMenuComponent.
	self assert: (menu hasComponentNamed: 'homeMenuItem').
	self assert: (menuItem := menu componentNamed: 'servicesMenuItem') notNil.
	self assert: menuItem class identicalTo: LuiDropDownMenuItem.
	self assert: (submenu := menuItem componentNamed: 'servicesMenuItemSubmenu') notNil.
	self assert: (developmentSubmenu := submenu componentNamed: 'developmentMenuItem') notNil.
	self assert: (menuItem := menu componentNamed: 'companyMenuItem') notNil.
	self assert: menuItem class identicalTo: LuiDropDownMenuItem.
	self assert: (menuItem := menu componentNamed: 'contactMenuItem') notNil.
	^ menu
]
