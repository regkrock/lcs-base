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
	menu := LuiNavigationMenu new.
	self assert: menu componentName equals: 'navMenu'.
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
	^ '<ul data-name="navMenu" data-StClass="LuiNavigationMenu" class="nav-links"><li id="150444848" data-name="contactsMenuItem" data-StClass="LuiDropDownMenuItem" class="submenu"><input id="3657561" data-name="contactsMenuItemCheckbox" data-StClass="LuiResponsiveNavigationMenuCheckbox" class="submenu-toggle" name="1" type="checkbox"/><input name="2" type="hidden"/><label id="157183262" data-name="contactsMenuItemLabel" data-StClass="LuiLabel" class="arrow-label" for="3657561">Contacts</label><ul id="242411529" data-name="contactsMenuItemSubmenu" data-StClass="LuiSubmenu" class="submenu"><li id="252948871" data-name="contact_itemA" data-StClass="LuiMenuItem" class="nav-item"><a id="36668297" data-name="anchor" data-StClass="LuiAnchor" href="#"><span id="168900298" data-name="span" data-StClass="LuiSpan">Aaaaa</span></a></li><li id="254613396" data-name="contact_itemB" data-StClass="LuiMenuItem" class="nav-item"><button id="244351063" data-name="button" data-StClass="LuiButton" type="button" class="pushButton"><span id="99646880" data-name="span" data-StClass="LuiSpan">Bbbbb</span></button></li><li id="256277921" data-name="contact_itemC" data-StClass="LuiMenuItem" class="nav-item"><button id="152666232" data-name="button" data-StClass="LuiButton" type="button" class="pushButton"><span id="266653" data-name="span" data-StClass="LuiSpan">Caaa</span></button></li><li id="158805041" data-name="subsubmenu" data-StClass="LuiDropDownMenuItem" class="submenu"><input id="70613564" data-name="subsubmenuCheckbox" data-StClass="LuiResponsiveNavigationMenuCheckbox" class="submenu-toggle" name="3" type="checkbox"/><input name="4" type="hidden"/><label id="161932981" data-name="subsubmenuLabel" data-StClass="LuiLabel" class="arrow-label" for="70613564">Subsubmenu</label><ul id="67465400" data-name="subsubmenuSubmenu" data-StClass="LuiSubmenu" class="submenu"><li id="147269099" data-name="homeSubmenu_itemB_a" data-StClass="LuiMenuItem" class="nav-item"><button id="143953834" data-name="button" data-StClass="LuiButton" type="button" class="pushButton"><span id="91563719" data-name="span" data-StClass="LuiSpan">Aaaaa</span></button></li><li id="148933624" data-name="homeSubmenu_itemB_b" data-StClass="LuiMenuItem" class="nav-item"><button id="52269003" data-name="button" data-StClass="LuiButton" type="button" class="pushButton"><span id="260618948" data-name="span" data-StClass="LuiSpan">Bbbbb</span></button></li><li id="150598149" data-name="homeSubmenu_itemB_c" data-StClass="LuiMenuItem" class="nav-item"><button id="229019628" data-name="button" data-StClass="LuiButton" type="button" class="pushButton"><span id="161238721" data-name="span" data-StClass="LuiSpan">Ccccc</span></button></li></ul></li></ul></li></ul>'
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
	navigationMenu := LuiNavigationMenu new.
	self assertRendered: navigationMenu equals: '<ul data-name="navMenu" data-StClass="LuiNavigationMenu" class="nav-links"></ul>'.
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
LuiMenuExamples >> softwareCompanyNavigationBar [
	<gtExample>
	| navigationbar |
	navigationbar := LuiNavigationBar new.
	navigationbar addComponent: LuiBrand newSeasBrand.
	navigationbar addComponent: (
			(LuiResponsiveNavigationMenuCheckbox named: 'menuToggle')
				assignStaticId: 'menu-toggle';
				yourself).
	navigationbar addComponent: (
			(LuiLabel named: 'menuToggleLabel')
				for: 'menu-toggle';
				cssClass: 'menu-btn';
				text: self hamburgerCodePointString;
				yourself).
	navigationbar addComponent: self softwareCompanynavigationMenu.

	^ navigationbar
]

{ #category : 'examples' }
LuiMenuExamples >> softwareCompanynavigationMenu [
	<gtExample>
	| menu |
	"menu := LuiNavigationMenuDefinitionExamples new 
		softwareCompanyNavigationMenuFromHandCodedStructure."
		
	menu :=  LuiNavigationMenuDefinitionExamples new 
	 	softwareCompanyNavigationMenuFromMenuDefinition.
	^ menu

]
