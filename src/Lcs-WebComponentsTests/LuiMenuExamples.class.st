Class {
	#name : 'LuiMenuExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiMenuExamples >> addSubSubMenuTo: submenu [ 
	| subSubMenu |
	subSubMenu := LuiMenu newSubmenuNamed: 'contactSubMenuSubmenu'.
	submenu  addComponent: subSubMenu.
	subSubMenu
		addComponent: (
			(LuiMenuItem named: 'contactMenuItemA_A')
				onClick: 'console.log("clicked Contact B Item A")';
				label: 'Contact B Item A';
				yourself);
		addComponent: (
			(LuiMenuItem named: 'contactMenuItemB_B')
				onClick: 'console.log("clicked Contact B Item B")';
				label: 'Contact B Item B';
				yourself).
]

{ #category : 'examples' }
LuiMenuExamples >> addSubmenuTo: contactMenuItem [ 
	| submenu contactMenuItemB  |

	submenu := (LuiMenu newSubmenuNamed: 'contactSubMenu').
	self assert: submenu componentName equals: 'contactSubMenu'.
	self assert: submenu cssClassesString equals: 'submenu'.
	contactMenuItem addComponent: submenu.
	submenu
		addComponent:
			((LuiMenuItem named: 'contactMenuItemA')
				onClick: 'console.log("clicked Contact A")';
				label: 'Contact A';
				cssClass: 'submenuItem';
				yourself);
		addComponent: (
			contactMenuItemB := (LuiMenuItem named: 'contactMenuItemB')
				onClick: 'console.log("clicked Contact B")';
				label: 'Contact B';
				cssClass: 'submenuItem';
				yourself);
		addComponent: (
			(LuiMenuItem named: 'contactMenuItemC')
				onClick: 'console.log("clicked Contact C")';
				label: 'Contact C';
				cssClass: 'submenuItem';
				yourself).
	self addSubSubMenuTo: contactMenuItemB
]

{ #category : 'examples' }
LuiMenuExamples >> exampleNavigationMenu [
	<gtExample>
	| menu homeMenuItem contactMenuItem aboutMenuItem |
	menu := LuiMenu newMainMenu.
	self assert: menu componentName equals: 'mainMenu'.
	self assert: menu cssClassesString equals: 'mainMenu'.
	homeMenuItem := (LuiMenuItem named: 'homeMenuItem')
						onClick: 'console.log("clicked Home")';
						buttonLabel: 'Home';
						title: 'Home Menu Item';
						yourself.
	contactMenuItem := (LuiMenuItem named: 'contactMenuItem')
						onClick: 'console.log("clicked Contact")';
						buttonLabel: 'Contact';
						title: 'Contact Menu Item';
						yourself.
	aboutMenuItem := (LuiMenuItem named: 'aboutMenuItem')
						onClick: 'console.log("clicked ")';
						buttonLabel: 'About';
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
	^ '<ul id="35201931" name="homeSubmenu" data-StClass="LuiMenu" class="submenu"><li id="253034342" name="homeSubmenu_a" data-StClass="LuiMenuItem" class="menuItem"><span id="13044305" name="span" data-StClass="LuiSpan">Aaaaa</span></li><li id="254698867" name="homeSubmenu_b" data-StClass="LuiMenuItem" class="menuItem"><span id="3212554" name="span" data-StClass="LuiSpan">Bbbbb</span></li><li id="256363392" name="homeSubmenu_c" data-StClass="LuiMenuItem" class="menuItem"><span id="261816259" name="span" data-StClass="LuiSpan">Caaa</span></li></ul>'
]

{ #category : 'private' }
LuiMenuExamples >> expectedHomeMenuItemHtml [
	^ '<li id="260104948" name="home" data-StClass="LuiMenuItem" title="Go to Home" class="menuItem"><span id="233879721" name="span" data-StClass="LuiSpan">Home</span><ul id="35201931" name="homeSubmenu" data-StClass="LuiMenu" class="submenu"><li id="201092461" name="homeSubmenu_itemA" data-StClass="LuiMenuItem" class="menuItem"><span id="244797086" name="span" data-StClass="LuiSpan">Aaaaa</span></li><li id="202756986" name="homeSubmenu_itemB" data-StClass="LuiMenuItem" class="menuItem"><span id="234965335" name="span" data-StClass="LuiSpan">Bbbbb</span></li><li id="204421511" name="homeSubmenu_itemC" data-StClass="LuiMenuItem" class="menuItem"><span id="225133584" name="span" data-StClass="LuiSpan">Caaa</span></li></ul></li>'
]

{ #category : 'private' }
LuiMenuExamples >> expectedNavigationWithSubmenuWithSubmenuHtml [
	^ '<ul name="navigation" data-StClass="LuiMenu" class="mainMenu"><li id="260104948" name="home" data-StClass="LuiMenuItem" title="Go to Home" class="menuItem"><span id="233879721" name="span" data-StClass="LuiSpan">Home</span><ul id="35201931" name="homeSubmenu" data-StClass="LuiMenu" class="submenu"><li id="201092461" name="homeSubmenu_itemA" data-StClass="LuiMenuItem" class="menuItem"><span id="244797086" name="span" data-StClass="LuiSpan">Aaaaa</span></li><li id="202756986" name="homeSubmenu_itemB" data-StClass="LuiMenuItem" class="menuItem"><span id="234965335" name="span" data-StClass="LuiSpan">Bbbbb</span><ul id="9792251" name="homeSubmenu_itemB_submenu" data-StClass="LuiMenu" class="submenu"><li id="201876382" name="homeSubmenu_itemB_a" data-StClass="LuiMenuItem" class="menuItem"><span id="63358571" name="span" data-StClass="LuiSpan">Aaaaa</span></li><li id="203540907" name="homeSubmenu_itemB_b" data-StClass="LuiMenuItem" class="menuItem"><span id="53526820" name="span" data-StClass="LuiSpan">Bbbbb</span></li><li id="205205432" name="homeSubmenu_itemB_c" data-StClass="LuiMenuItem" class="menuItem"><span id="43695069" name="span" data-StClass="LuiSpan">Ccccc</span></li></ul></li><li id="204421511" name="homeSubmenu_itemC" data-StClass="LuiMenuItem" class="menuItem"><span id="225133584" name="span" data-StClass="LuiSpan">Caaa</span></li></ul></li><li id="75012251" name="contact" data-StClass="LuiMenuItem" class="menuItem"><span id="31026772" name="span" data-StClass="LuiSpan">Contact</span></li><li id="99049242" name="about" data-StClass="LuiMenuItem" class="menuItem"><span id="40764023" name="span" data-StClass="LuiSpan">About</span></li></ul>'
]

{ #category : 'private' }
LuiMenuExamples >> expectedSubmenuHtml [
	^ '<ul id="35201931" name="homeSubmenu" data-StClass="LuiMenu" class="submenu"><li id="201092461" name="homeSubmenu_itemA" data-StClass="LuiMenuItem" class="menuItem"><span id="244797086" name="span" data-StClass="LuiSpan">Aaaaa</span></li><li id="202756986" name="homeSubmenu_itemB" data-StClass="LuiMenuItem" class="menuItem"><span id="234965335" name="span" data-StClass="LuiSpan">Bbbbb</span></li><li id="204421511" name="homeSubmenu_itemC" data-StClass="LuiMenuItem" class="menuItem"><span id="225133584" name="span" data-StClass="LuiSpan">Caaa</span></li></ul>'
]

{ #category : 'examples' }
LuiMenuExamples >> navigationWithSubmenu [
	<gtExample>
	| navigationMenu homeMenuItem homeSubmenu |
	navigationMenu := self simpleNavigationMenu.
	homeMenuItem := navigationMenu componentNamed: 'home'.
	homeSubmenu := LuiMenu newSubmenuNamed: 'homeSubmenu'.
	homeMenuItem addComponent: homeSubmenu.
	self assert: homeSubmenu componentName equals: 'homeSubmenu'.
	self assert: homeSubmenu cssClassesString equals: 'submenu'.
	homeSubmenu 
		addComponent: ((LuiMenuItem named: 'homeSubmenu_itemA') label: 'Aaaaa');
		addComponent: ((LuiMenuItem named: 'homeSubmenu_itemB') label: 'Bbbbb');
		addComponent: ((LuiMenuItem named: 'homeSubmenu_itemC') label: 'Caaa').
	self assertRendered: homeSubmenu equals: self expectedSubmenuHtml.
	self assertRendered: homeMenuItem equals: self expectedHomeMenuItemHtml.
	^ navigationMenu
]

{ #category : 'examples' }
LuiMenuExamples >> navigationWithSubmenuWithSubmenu [
	<gtExample>
	| navigationMenu homeSubmenuB homeSubmenuBsubmenu |
	navigationMenu := self navigationWithSubmenu.
	homeSubmenuB := navigationMenu componentNamed: 'home/homeSubmenu/homeSubmenu_itemB'.
	homeSubmenuBsubmenu := LuiMenu newSubmenuNamed: 'homeSubmenu_itemB_submenu'.
	homeSubmenuB addComponent: homeSubmenuBsubmenu.
	homeSubmenuBsubmenu 
		addComponent: ((LuiMenuItem named: 'homeSubmenu_itemB_a') label: 'Aaaaa');
		addComponent: ((LuiMenuItem named: 'homeSubmenu_itemB_b') label: 'Bbbbb');
		addComponent: ((LuiMenuItem named: 'homeSubmenu_itemB_c') label: 'Ccccc').
	self assertRendered: navigationMenu equals: self expectedNavigationWithSubmenuWithSubmenuHtml.
	^ navigationMenu
]

{ #category : 'examples' }
LuiMenuExamples >> newComponent [
	<gtExample>
	| navigationMenu |
	navigationMenu := LuiMenu newMainMenuNamed: 'navigation'.
	self assertRendered: navigationMenu equals: '<ul name="navigation" data-StClass="LuiMenu" class="mainMenu"></ul>'.
	^ navigationMenu
]

{ #category : 'examples' }
LuiMenuExamples >> simpleNavigationMenu [
	<gtExample>
	| menuItem menuItemButton navigationMenu |
	navigationMenu := LuiMenu newMainMenuNamed: 'navigation'.
	self assert: navigationMenu componentName equals: 'navigation'.
	self assert: navigationMenu cssClassesString equals: 'mainMenu'.
	navigationMenu buildFrom: LuiNavigationMenuDefinitionExamples new navigationMenuWithThreeMenuItemDefinitions .

	self assert: navigationMenu components size = 3.
	menuItem := navigationMenu componentAtIndex: 1.
	self assert: menuItem componentName = 'home'.
	self assert: menuItem label = 'Home'.
	self assert: menuItem cssClassesString = 'menuItem'.
	self assert: menuItem components size = 1.
	menuItemButton := menuItem componentAtIndex: 1.
	"self assert: menuItemButton componentName = 'button'."
	"self assert: menuItemButton label = 'Home'."
	^ navigationMenu
]
