Class {
	#name : #LuiNavBarWithSubSubMenusTest,
	#superclass : #LuiFunctionalTest,
	#category : #'Lcs-WebComponentsTests-Functional'
}

{ #category : #setup }
LuiNavBarWithSubSubMenusTest >> addMainNavigationMenuTo: aMainMenu [
	aMainMenu buildFrom: self menuDefinition
]

{ #category : #initialize }
LuiNavBarWithSubSubMenusTest >> initialize [
	| mainPage |
	super initialize.
	self componentName: 'root'.
	self componentId: 'root'.
	self addComponent: (mainPage := LuiMainPage named: 'mainPage' on: self).

	self addMainNavigationMenuTo: (mainPage componentNamed: 'header/navigation').
	(mainPage componentNamed: 'header/title') domainObject: 'LCS Example'.
	(mainPage componentNamed: 'applicationArea') homeMessage: self latinText
]

{ #category : #initialize }
LuiNavBarWithSubSubMenusTest >> latinText [
	^ 'Lorem ipsum odor amet, consectetuer adipiscing elit. Porttitor bibendum natoque, faucibus aliquet montes fames nisi nisi. Praesent eget dignissim metus efficitur lobortis aliquet dis montes libero. Pulvinar maximus torquent sapien feugiat sed ac imperdiet dignissim. Ridiculus enim potenti risus; fringilla efficitur inceptos dis. Quis a habitant quam non at posuere. Efficitur aptent iaculis ac blandit luctus finibus placerat primis elementum. Auctor odio per orci mi, conubia nibh. Rutrum gravida nascetur curabitur felis lectus tempor aliquam enim duis.

Urna arcu adipiscing feugiat faucibus nisi mauris. Augue mus suscipit risus integer senectus pharetra. Eget ligula commodo nisi pellentesque integer. Magnis ac mollis risus ullamcorper vulputate erat. Aptent metus integer massa ante mattis non aptent? Dis facilisis venenatis facilisis, imperdiet lobortis orci. Dictum finibus urna convallis arcu ultricies himenaeos. Hac nam suscipit maecenas tincidunt tincidunt eget eu habitasse. Phasellus at blandit dapibus cursus scelerisque et primis imperdiet.'
]

{ #category : #setup }
LuiNavBarWithSubSubMenusTest >> menuDefinition [
	^ LcsMainMenuDefinition menuBarWithSubSubMenuDefinition
]

{ #category : #rendering }
LuiNavBarWithSubSubMenusTest >> renderComponentOn: html [
	html div 
		addCommonProperties: self;
		with: [
			self renderSubcomponentsOn: html ]
]

{ #category : #updating }
LuiNavBarWithSubSubMenusTest >> updateRoot: aRoot [

	super updateRoot: aRoot.
	aRoot stylesheet url: LcsFunctionalTestFileLibrary / #mainCss
]
