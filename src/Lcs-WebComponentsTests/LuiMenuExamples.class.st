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

{ #category : 'private' }
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
						callback: [ Transcript cr; show: 'homeMenuItem clicked' ];
						buttonLabel: 'Home';
						title: 'Home Menu Item';
						yourself.
	contactMenuItem := (LuiMenuItem named: 'contactMenuItem')
						onClick: 'console.log("clicked Contact")';
						callback: [ Transcript cr; show: 'contactMenuItem clicked' ];
						buttonLabel: 'Contact';
						title: 'Contact Menu Item';
						yourself.
	aboutMenuItem := (LuiMenuItem named: 'aboutMenuItem')
						onClick: 'console.log("clicked ")';
						callback: [ Transcript cr; show: 'aboutMenuItem clicked' ];
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
	^ '<ul id="35201931" data-name="homeSubmenu" data-StClass="LuiMenu" class="submenu"><li id="253034342" data-name="homeSubmenu_a" data-StClass="LuiMenuItem" class="menuItem"><span id="13044305" name="span" data-StClass="LuiSpan">Aaaaa</span></li><li id="254698867" data-name="homeSubmenu_b" data-StClass="LuiMenuItem" class="menuItem"><span id="3212554" data-name="span" data-StClass="LuiSpan">Bbbbb</span></li><li id="256363392" data-name="homeSubmenu_c" data-StClass="LuiMenuItem" class="menuItem"><span id="261816259" data-name="span" data-StClass="LuiSpan">Caaa</span></li></ul>'
]

{ #category : 'private' }
LuiMenuExamples >> expectedHomeMenuItemHtml [
	^ '<li id="260104948" data-name="home" data-StClass="LuiMenuItem" title="Go to Home" class="menuItem"><button id="90512695" data-name="button" data-StClass="LuiPushButton" name="button" type="button"><span id="165968640" data-name="span" data-StClass="LuiSpan">Home</span></button><ul id="35201931" data-name="homeSubmenu" data-StClass="LuiMenu" class="submenu"><li id="201092461" data-name="homeSubmenu_itemA" data-StClass="LuiMenuItem" class="menuItem"><button id="31074292" data-name="button" data-StClass="LuiPushButton" name="button" type="button"><span id="101108137" data-name="span" data-StClass="LuiSpan">Aaaaa</span></button></li><li id="202756986" data-name="homeSubmenu_itemB" data-StClass="LuiMenuItem" class="menuItem"><button id="207824917" data-name="button" data-StClass="LuiPushButton" name="button" type="button"><span id="1727910" data-name="span" data-StClass="LuiSpan">Bbbbb</span></button></li><li id="204421511" data-name="homeSubmenu_itemC" data-StClass="LuiMenuItem" class="menuItem"><button id="116140086" data-name="button" data-StClass="LuiPushButton" name="button" type="button"><span id="170783139" data-name="span" data-StClass="LuiSpan">Caaa</span></button></li></ul></li>'
]

{ #category : 'private' }
LuiMenuExamples >> expectedNavigationWithSubmenuWithSubmenuHtml [
	^ '<ul data-name="navigation" data-StClass="LuiMenu" class="mainMenu"><li id="260104948" data-name="home" data-StClass="LuiMenuItem" title="Go to Home" class="menuItem"><button id="90512695" data-name="button" data-StClass="LuiPushButton" name="button" type="button"><span id="165968640" data-name="span" data-StClass="LuiSpan">Home</span></button><ul id="35201931" data-name="homeSubmenu" data-StClass="LuiMenu" class="submenu"><li id="201092461" data-name="homeSubmenu_itemA" data-StClass="LuiMenuItem" class="menuItem"><button id="31074292" data-name="button" data-StClass="LuiPushButton" name="button" type="button"><span id="101108137" data-name="span" data-StClass="LuiSpan">Aaaaa</span></button></li><li id="202756986" data-name="homeSubmenu_itemB" data-StClass="LuiMenuItem" class="menuItem"><button id="207824917" data-name="button" data-StClass="LuiPushButton" name="button" type="button"><span id="1727910" data-name="span" data-StClass="LuiSpan">Bbbbb</span></button><ul id="9792251" data-name="homeSubmenu_itemB_submenu" data-StClass="LuiMenu" class="submenu"><li id="201876382" data-name="homeSubmenu_itemB_a" data-StClass="LuiMenuItem" class="menuItem"><button id="219540041" data-name="button" data-StClass="LuiPushButton" name="button" type="button"><span id="169511562" data-name="span" data-StClass="LuiSpan">Aaaaa</span></button></li><li id="203540907" data-name="homeSubmenu_itemB_b" data-StClass="LuiMenuItem" class="menuItem"><button id="127855210" data-name="button" data-StClass="LuiPushButton" name="button" type="button"><span id="70131335" data-name="span" data-StClass="LuiSpan">Bbbbb</span></button></li><li id="205205432" data-name="homeSubmenu_itemB_c" data-StClass="LuiMenuItem" class="menuItem"><button id="36170379" data-name="button" data-StClass="LuiPushButton" name="button" type="button"><span id="239186564" data-name="span" data-StClass="LuiSpan">Ccccc</span></button></li></ul></li><li id="204421511" data-name="homeSubmenu_itemC" data-StClass="LuiMenuItem" class="menuItem"><button id="116140086" data-name="button" data-StClass="LuiPushButton" name="button" type="button"><span id="170783139" data-name="span" data-StClass="LuiSpan">Caaa</span></button></li></ul></li><li id="75012251" data-name="contact" data-StClass="LuiMenuItem" class="menuItem"><button id="95846170" data-name="button" data-StClass="LuiPushButton" name="button" type="button"><span id="162308727" data-name="span" data-StClass="LuiSpan">Contact</span></button></li><li id="99049242" data-name="about" data-StClass="LuiMenuItem" class="menuItem"><button id="162586165" data-name="button" data-StClass="LuiPushButton" name="button" type="button"><span id="263620422" data-name="span" data-StClass="LuiSpan">About</span></button></li></ul>'
]

{ #category : 'private' }
LuiMenuExamples >> expectedSubmenuHtml [
	^ '<ul id="35201931" data-name="homeSubmenu" data-StClass="LuiMenu" class="submenu"><li id="201092461" data-name="homeSubmenu_itemA" data-StClass="LuiMenuItem" class="menuItem"><button id="31074292" data-name="button" data-StClass="LuiPushButton" name="button" type="button"><span id="101108137" data-name="span" data-StClass="LuiSpan">Aaaaa</span></button></li><li id="202756986" data-name="homeSubmenu_itemB" data-StClass="LuiMenuItem" class="menuItem"><button id="207824917" data-name="button" data-StClass="LuiPushButton" name="button" type="button"><span id="1727910" data-name="span" data-StClass="LuiSpan">Bbbbb</span></button></li><li id="204421511" data-name="homeSubmenu_itemC" data-StClass="LuiMenuItem" class="menuItem"><button id="116140086" data-name="button" data-StClass="LuiPushButton" name="button" type="button"><span id="170783139" data-name="span" data-StClass="LuiSpan">Caaa</span></button></li></ul>'
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
		addComponent: ((LuiMenuItem named: 'homeSubmenu_itemA') buttonLabel: 'Aaaaa');
		addComponent: ((LuiMenuItem named: 'homeSubmenu_itemB') buttonLabel: 'Bbbbb');
		addComponent: ((LuiMenuItem named: 'homeSubmenu_itemC') buttonLabel: 'Caaa').
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
		addComponent: ((LuiMenuItem named: 'homeSubmenu_itemB_a') buttonLabel: 'Aaaaa');
		addComponent: ((LuiMenuItem named: 'homeSubmenu_itemB_b') buttonLabel: 'Bbbbb');
		addComponent: ((LuiMenuItem named: 'homeSubmenu_itemB_c') buttonLabel: 'Ccccc').
	self assertRendered: navigationMenu equals: self expectedNavigationWithSubmenuWithSubmenuHtml.
	^ navigationMenu
]

{ #category : 'examples' }
LuiMenuExamples >> newComponent [
	<gtExample>
	| navigationMenu |
	navigationMenu := LuiMenu newMainMenuNamed: 'navigation'.
	self assertRendered: navigationMenu equals: '<ul data-name="navigation" data-StClass="LuiMenu" class="mainMenu"></ul>'.
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
