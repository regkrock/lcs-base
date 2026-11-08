Class {
	#name : 'LuiMenuExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'private' }
LuiMenuExamples >> addSubSubMenuTo: submenu [ 
	| subSubMenu |
	subSubMenu := ((LuiMenu newSubmenuNamed: 'contactSubMenuSubmenu')
					removeAllCssClasses;
					cssClass: LuiCssClassesMap / #'submenu-right';
					yourself).
	submenu  addComponent: subSubMenu.
	subSubMenu
		addComponent: (
			(LuiMenuItem named: 'contactMenuItemA_A')
				anchorLabel: 'Contact B Item A';
				callback: [ Transcript cr; show: 'clicked Contact B Item A' ];
				yourself);
		addComponent: (
			(LuiMenuItem named: 'contactMenuItemB_B')
				anchorLabel: 'Contact B Item B';
				callback: [ Transcript cr; show: 'clicked Contact B Item B' ];
				yourself).
]

{ #category : 'private' }
LuiMenuExamples >> addSubmenuTo: contactMenuItem [ 
	| submenu contactMenuItemB  |

	submenu := (LuiMenu newSubmenuNamed: 'contactSubMenu')
				removeAllCssClasses;
				cssClass: LuiCssClassesMap / #'submenu';
				yourself.
	self assert: submenu componentName equals: 'contactSubMenu'.
	"self assert: submenu cssClassesString equals: 'submenu'."
	contactMenuItem addComponent: submenu.
	submenu
		addComponent:
			((LuiMenuItem named: 'contactMenuItemA')
				removeAllCssClasses;
				anchorLabel: 'Contact A';
				callback: [ Transcript cr; show: 'clicked Contact A' ];
				"cssClass: 'submenuItem';"
				yourself);
		addComponent: (
			contactMenuItemB := (LuiMenuItem named: 'contactMenuItemB')
				removeAllCssClasses;
				anchorLabel: 'Contact B';
				callback: [ Transcript cr; show: 'clicked Contact B' ];
				cssClass: 'dropdown';
				yourself);
		addComponent: (
			(LuiMenuItem named: 'contactMenuItemC')
				removeAllCssClasses;
				anchorLabel: 'Contact C';
				callback: [ Transcript cr; show: 'clicked Contact C' ];
				"cssClass: 'submenuItem';"
				yourself).
	self addSubSubMenuTo: contactMenuItemB
]

{ #category : 'examples' }
LuiMenuExamples >> contactsDropdownMenuItem [
	<gtExample>
	| menuItem checkboxComponent labelComponent submenuComponent |
	menuItem :=  LuiDropDownMenuItem named: 'contactsMenuItem' label: 'Contacts'.
	self assert: menuItem class identicalTo: LuiDropDownMenuItem.
	self assert: menuItem components size equals: 3.
	checkboxComponent := menuItem checkboxComponent.
	labelComponent := menuItem labelComponent.
	submenuComponent := menuItem submenuComponent.
	self assert: checkboxComponent class identicalTo: LuiResponsiveNavigationMenuCheckbox.
	self assert: checkboxComponent componentName equals: 'contactsMenuItemCheckbox'.
	self assert: checkboxComponent cssClassesString equals: 'submenu-toggle'.
	self assert: labelComponent class identicalTo: LuiLabel.
	self assert: labelComponent componentName equals: 'contactsMenuItemLabel'.
	self assert: labelComponent cssClassesString equals: 'arrow-label'.
	self assert: labelComponent for equals: nil.
	self assert: submenuComponent class identicalTo: LuiSubmenu.
	self assert: submenuComponent componentName equals: 'contactsMenuItemSubmenu'.
	self assert: submenuComponent cssClassesString equals: 'submenu'.
	^ menuItem
]

{ #category : 'examples' }
LuiMenuExamples >> exampleNavigationMenu [
	<gtExample>
	| menu homeMenuItem contactMenuItem aboutMenuItem |
	menu := LuiMainMenu newMainMenu.
	self assert: menu componentName equals: 'mainMenu'.
	self assert: menu cssClassesString equals: 'nav-links'.
	homeMenuItem := (LuiMenuItem named: 'homeMenuItem')
						anchorLabel: 'Home';
						removeAllCssClasses;
						callback: [ Transcript cr; show: 'homeMenuItem clicked' ];
						title: 'Home Menu Item';
						yourself.
	contactMenuItem := (LuiMenuItem named: 'contactMenuItem')
						anchorLabel: 'Contact';
						cssClass: 'dropdown';
						callback: [ Transcript cr; show: 'contactMenuItem clicked' ];
						title: 'Contact Menu Item';
						yourself.
	aboutMenuItem := (LuiMenuItem named: 'aboutMenuItem')
						anchorLabel: 'About';
						removeAllCssClasses;
						"onClick: 'console.log(clicked About)';"
						callback: [ Transcript cr; show: 'aboutMenuItem clicked' ];
						title: 'About Menu Item';
						yourself.
	menu
		addComponent: homeMenuItem;
		addComponent: contactMenuItem;
		addComponent: aboutMenuItem.
	
	self addSubmenuTo: contactMenuItem.
	^ menu
]

{ #category : 'private' }
LuiMenuExamples >> expectedHomeMenuHtml [
	^ '<ul id="35201931" data-name="homeSubmenu" data-StClass="LuiMenu" class="submenu"><li id="253034342" data-name="homeSubmenu_a" data-StClass="LuiMenuItem" class="menuItem"><span id="13044305" name="span" data-StClass="LuiSpan">Aaaaa</span></li><li id="254698867" data-name="homeSubmenu_b" data-StClass="LuiMenuItem" class="menuItem"><span id="3212554" data-name="span" data-StClass="LuiSpan">Bbbbb</span></li><li id="256363392" data-name="homeSubmenu_c" data-StClass="LuiMenuItem" class="menuItem"><span id="261816259" data-name="span" data-StClass="LuiSpan">Caaa</span></li></ul>'
]

{ #category : 'private' }
LuiMenuExamples >> expectedHomeMenuItemHtml [
	^ '<li id="183941010" data-name="home" data-StClass="LuiMenuItem" title="Go to Home" class="menuItem"><button id="134987149" data-name="button" data-StClass="LuiButton" type="button" class="pushButton"><span id="106457662" data-name="span" data-StClass="LuiSpan">Home</span></button><ul id="244126409" data-name="homeSubmenu" data-StClass="LuiMenu" class="submenu"><li id="66672859" data-name="homeSubmenu_itemA" data-StClass="LuiMenuItem" class="menuItem"><button id="241080410" data-name="button" data-StClass="LuiButton" type="button" class="pushButton"><span id="141020855" data-name="span" data-StClass="LuiSpan">Aaaaa</span></button></li><li id="68337384" data-name="homeSubmenu_itemB" data-StClass="LuiMenuItem" class="menuItem"><button id="149395579" data-name="button" data-StClass="LuiButton" type="button" class="pushButton"><span id="41640628" data-name="span" data-StClass="LuiSpan">Bbbbb</span></button></li><li id="70001909" data-name="homeSubmenu_itemC" data-StClass="LuiMenuItem" class="menuItem"><button id="57710748" data-name="button" data-StClass="LuiButton" type="button" class="pushButton"><span id="210695857" data-name="span" data-StClass="LuiSpan">Caaa</span></button></li></ul></li>'
]

{ #category : 'private' }
LuiMenuExamples >> expectedNavigationWithSubmenuWithSubmenuHtml [
	^ '<ul data-name="mainMenu" data-StClass="LuiMenu" class="menu"><li id="101329548" data-name="contactsMenuItem" data-StClass="LuiDropDownMenuItem" class="submenu"><input id="83079045" data-name="contactsMenuItemCheckbox" data-StClass="LuiResponsiveNavigationMenuCheckbox" class="submenu-toggle" name="1" type="checkbox"/><input name="2" type="hidden"/><label id="157167002" data-name="contactsMenuItemLabel" data-StClass="LuiLabel" class="arrow-label" for="83079045">Contacts</label><ul id="110463461" data-name="contactsMenuItemSubmenu" data-StClass="LuiSubmenu" class="submenu"><li id="163414275" data-name="contact_itemA" data-StClass="LuiMenuItem" class="nav-item"><a id="107223925" data-name="anchor" data-StClass="LuiAnchor" href="#"><span id="94226310" data-name="span" data-StClass="LuiSpan">Aaaaa</span></a></li><li id="165078800" data-name="contact_itemB" data-StClass="LuiMenuItem" class="nav-item"><button id="46471235" data-name="button" data-StClass="LuiButton" type="button" class="pushButton"><span id="24972892" data-name="span" data-StClass="LuiSpan">Bbbbb</span></button></li><li id="166743325" data-name="contact_itemC" data-StClass="LuiMenuItem" class="nav-item"><button id="223221860" data-name="button" data-StClass="LuiButton" type="button" class="pushButton"><span id="194028121" data-name="span" data-StClass="LuiSpan">Caaa</span></button></li><li id="99850941" data-name="subsubmenu" data-StClass="LuiDropDownMenuItem" class="submenu"><input id="172562616" data-name="subsubmenuCheckbox" data-StClass="LuiResponsiveNavigationMenuCheckbox" class="submenu-toggle" name="3" type="checkbox"/><input name="4" type="hidden"/><label id="64038977" data-name="subsubmenuLabel" data-StClass="LuiLabel" class="arrow-label" for="172562616">Subsubmenu</label><ul id="68748836" data-name="subsubmenuSubmenu" data-StClass="LuiSubmenu" class="submenu"><li id="137721623" data-name="homeSubmenu_itemB_a" data-StClass="LuiMenuItem" class="nav-item"><button id="983558" data-name="button" data-StClass="LuiButton" type="button" class="pushButton"><span id="69046835" data-name="span" data-StClass="LuiSpan">Aaaaa</span></button></li><li id="139386148" data-name="homeSubmenu_itemB_b" data-StClass="LuiMenuItem" class="nav-item"><button id="177734183" data-name="button" data-StClass="LuiButton" type="button" class="pushButton"><span id="238102064" data-name="span" data-StClass="LuiSpan">Bbbbb</span></button></li><li id="141050673" data-name="homeSubmenu_itemB_c" data-StClass="LuiMenuItem" class="nav-item"><button id="86049352" data-name="button" data-StClass="LuiButton" type="button" class="pushButton"><span id="138721837" data-name="span" data-StClass="LuiSpan">Ccccc</span></button></li></ul></li></ul></li></ul>'
]

{ #category : 'private' }
LuiMenuExamples >> expectedSubmenuHtml [
	^ '<ul id="244126409" data-name="homeSubmenu" data-StClass="LuiMenu" class="submenu"><li id="66672859" data-name="homeSubmenu_itemA" data-StClass="LuiMenuItem" class="menuItem"><button id="241080410" data-name="button" data-StClass="LuiButton" type="button" class="pushButton"><span id="141020855" data-name="span" data-StClass="LuiSpan">Aaaaa</span></button></li><li id="68337384" data-name="homeSubmenu_itemB" data-StClass="LuiMenuItem" class="menuItem"><button id="149395579" data-name="button" data-StClass="LuiButton" type="button" class="pushButton"><span id="41640628" data-name="span" data-StClass="LuiSpan">Bbbbb</span></button></li><li id="70001909" data-name="homeSubmenu_itemC" data-StClass="LuiMenuItem" class="menuItem"><button id="57710748" data-name="button" data-StClass="LuiButton" type="button" class="pushButton"><span id="210695857" data-name="span" data-StClass="LuiSpan">Caaa</span></button></li></ul>'
]

{ #category : 'examples' }
LuiMenuExamples >> hamburgerCodePointString [
	^ String with: (Character codePoint: 16r2630)
]

{ #category : 'examples' }
LuiMenuExamples >> navigationMenuWithEmptySubmenu [
	<gtExample>
	| navigationMenu dropDownMenuItem |
	navigationMenu := self newNavigationMenuComponent.
	dropDownMenuItem := self contactsDropdownMenuItem.
	self 
		assert: dropDownMenuItem labelComponent for 
		equals: nil.
	navigationMenu addComponent: dropDownMenuItem.
	self assert: navigationMenu components includes: dropDownMenuItem.
	self 
		assert: dropDownMenuItem labelComponent for 
		equals: dropDownMenuItem checkboxComponent componentId.
	^ navigationMenu
]

{ #category : 'examples' }
LuiMenuExamples >> navigationWithSubmenu [
	<gtExample>
	| navigationMenu contactsMenuItem contactsMenuItemSubmenu |
	navigationMenu := self navigationMenuWithEmptySubmenu.
	contactsMenuItem := navigationMenu componentNamed: 'contactsMenuItem'.
	contactsMenuItem 
		addMenuItem: ((LuiMenuItem named: 'contact_itemA') 
						href: '#';
						label: 'Aaaaa';
						yourself);
		addMenuItem: ((LuiMenuItem named: 'contact_itemB') buttonLabel: 'Bbbbb');
		addMenuItem: ((LuiMenuItem named: 'contact_itemC') buttonLabel: 'Caaa').
	contactsMenuItemSubmenu := contactsMenuItem submenuComponent.
	self assert: contactsMenuItemSubmenu components size equals: 3.
	"self assertRendered: homeSubmenu equals: self expectedSubmenuHtml.
	self assertRendered: homeMenuItem equals: self expectedHomeMenuItemHtml."
	^ navigationMenu
]

{ #category : 'examples' }
LuiMenuExamples >> navigationWithSubmenuWithSubmenu [
	<gtExample>
	| navigationMenu submenu subsubmenuItem |
	navigationMenu := self navigationWithSubmenu.
	submenu := navigationMenu componentNamed: 'contactsMenuItem/contactsMenuItemSubmenu'.
	subsubmenuItem := LuiDropDownMenuItem named: 'subsubmenu'  label: 'Subsubmenu'.
	submenu addComponent: subsubmenuItem.
	subsubmenuItem 
		addMenuItem: ((LuiMenuItem named: 'homeSubmenu_itemB_a') buttonLabel: 'Aaaaa');
		addMenuItem: ((LuiMenuItem named: 'homeSubmenu_itemB_b') buttonLabel: 'Bbbbb');
		addMenuItem: ((LuiMenuItem named: 'homeSubmenu_itemB_c') buttonLabel: 'Ccccc').
	self assertRendered: navigationMenu equals: self expectedNavigationWithSubmenuWithSubmenuHtml.
	^ navigationMenu
]

{ #category : 'examples' }
LuiMenuExamples >> newNavigationMenuComponent [
	<gtExample>
	| navigationMenu |
	navigationMenu := LuiMenu newMainMenuNamed: 'mainMenu'.
	self assertRendered: navigationMenu equals: '<ul data-name="mainMenu" data-StClass="LuiMenu" class="menu"></ul>'.
	^ navigationMenu
]

{ #category : 'examples' }
LuiMenuExamples >> simpleNavigationMenu [
	<gtExample>
	| menuItem menuItemButton navigationMenu |
	navigationMenu := self newNavigationMenuComponent.
	navigationMenu buildFrom: LuiNavigationMenuDefinitionExamples new navigationMenuWithThreeMenuItemDefinitions .

	self assert: navigationMenu components size = 3.
	menuItem := navigationMenu componentAtIndex: 1.
	self assert: menuItem class identicalTo: LuiMenuItem.
	self assert: menuItem componentName = 'homeMenuItem'.
	self assert: menuItem label = 'Home'.
	self assert: menuItem cssClassesString equals: 'nav-item'.
	self assert: menuItem components size = 1.
	menuItemButton := menuItem componentAtIndex: 1.
	self assert: menuItemButton componentName = 'button'.
	self assert: menuItemButton label = 'Home'.	
	
	menuItem := navigationMenu componentAtIndex: 2.
	self assert: menuItem class identicalTo: LuiMenuItem.
	self assert: menuItem componentName = 'contactMenuItem'.
	self assert: menuItem label = 'Contact'.
	self assert: menuItem cssClassesString equals: 'nav-item'.
	self assert: menuItem components size = 1.
	menuItemButton := menuItem componentAtIndex: 1.
	self assert: menuItemButton componentName = 'button'.
	self assert: menuItemButton label = 'Contact'.	

	menuItem := navigationMenu componentAtIndex: 3.
	self assert: menuItem class identicalTo: LuiMenuItem.
	self assert: menuItem componentName = 'aboutMenuItem'.
	self assert: menuItem label = 'About'.
	self assert: menuItem cssClassesString equals: 'nav-item'.
	self assert: menuItem components size = 1.
	menuItemButton := menuItem componentAtIndex: 1.
	self assert: menuItemButton componentName = 'button'.
	self assert: menuItemButton label = 'About'.	

	^ navigationMenu
]

{ #category : 'examples' }
LuiMenuExamples >> softwareCompanyMainMenu [
	<gtExample>
	| menu |
	"menu := LuiNavigationMenuDefinitionExamples new 
		softwareCompanyNavbarMainMenuFromHandCodedStructure."
		
	menu :=  LuiNavigationMenuDefinitionExamples new 
	 	softwareCompanyNavbarMainMenuFromMenuDefinition.
	^ menu

]

{ #category : 'examples' }
LuiMenuExamples >> softwareCompanyNavbar [
	<gtExample>
	| navbar |
	navbar := LuiNavigationBar named: 'navbar'.
	navbar addComponent: LuiBrand newSeasBrand.
	navbar addComponent: (
			(LuiResponsiveNavigationMenuCheckbox named: 'menuToggle')
				assignStaticId: 'menu-toggle';
				yourself).
	navbar addComponent: (
			(LuiLabel named: 'menuToggleLabel')
				for: 'menu-toggle';
				cssClass: 'menu-btn';
				text: self hamburgerCodePointString;
				yourself).
	navbar addComponent: self softwareCompanyMainMenu.

	^ navbar
]
