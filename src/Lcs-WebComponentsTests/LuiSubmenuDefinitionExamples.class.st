Class {
	#name : 'LuiSubmenuDefinitionExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'as yet unclassified' }
LuiSubmenuDefinitionExamples >> menu1Definition [
	<gtExample>
	| menuDefinition |
	menuDefinition := self newDefinition.
	menuDefinition label: 'Menu 1'.
	self assert: menuDefinition menuComponentDefintions isEmpty.
	self assert: menuDefinition label equals: 'Menu 1'.
	self assert: menuDefinition componentName equals: 'menu1'.
	^ menuDefinition
]

{ #category : 'as yet unclassified' }
LuiSubmenuDefinitionExamples >> menu1DefinitionWith3Submenus [
	<gtExample>
	| menuDefinition |
	menuDefinition := self menu1Definition.
	menuDefinition addDefinition: (LuiMenuItemDefinitionExamples new newDefinitionWithLabel: 'Menu 1 Item 1').
	menuDefinition addDefinition: (LuiMenuItemDefinitionExamples new newDefinitionWithLabel: 'Menu 1 Item 2').
	menuDefinition addDefinition: (LuiMenuItemDefinitionExamples new newDefinitionWithLabel: 'Menu 1 Item 3').
	self assert: menuDefinition menuComponentDefintions size = 3.
	self assert: (menuDefinition menuComponentDefintions at: 1) componentName equals: 'menu1Item1'.
	self assert: (menuDefinition menuComponentDefintions at: 2) componentName equals: 'menu1Item2'.
	self assert: (menuDefinition menuComponentDefintions at: 3) componentName equals: 'menu1Item3'.
	^ menuDefinition
]

{ #category : 'as yet unclassified' }
LuiSubmenuDefinitionExamples >> menu2Definition [
	<gtExample>
	| menuDefinition |
	menuDefinition := self newDefinition.
	menuDefinition label: 'Menu 2'.
	self assert: menuDefinition menuComponentDefintions isEmpty.
	self assert: menuDefinition label equals: 'Menu 2'.
	self assert: menuDefinition componentName equals: 'menu2'.
	^ menuDefinition
]

{ #category : 'as yet unclassified' }
LuiSubmenuDefinitionExamples >> menu2DefinitionWith2Submenus [
	<gtExample>
	| menuDefinition |
	menuDefinition := self menu2Definition.
	menuDefinition addDefinition: (LuiMenuItemDefinitionExamples new newDefinitionWithLabel: 'Menu 2 Item 1').
	menuDefinition addDefinition: (LuiMenuItemDefinitionExamples new newDefinitionWithLabel: 'Menu 2 Item 2').
	self assert: menuDefinition menuComponentDefintions size = 2.
	self assert: (menuDefinition menuComponentDefintions at: 1) componentName equals: 'menu2Item1'.
	self assert: (menuDefinition menuComponentDefintions at: 2) componentName equals: 'menu2Item2'.
	^ menuDefinition
]

{ #category : 'as yet unclassified' }
LuiSubmenuDefinitionExamples >> menu3Definition [
	<gtExample>
	| menuDefinition |
	menuDefinition := self newDefinition.
	menuDefinition label: 'Menu 3'.
	self assert: menuDefinition componentName equals: 'menu3'.
	self assert: menuDefinition menuComponentDefintions isEmpty.
	self assert: menuDefinition label equals: 'Menu 3'.
	^ menuDefinition
]

{ #category : 'as yet unclassified' }
LuiSubmenuDefinitionExamples >> menu3Definition3SubmenuLevels [
	<gtExample>
	| menuDefinition |
	menuDefinition := self menu3Definition.
	menuDefinition addDefinition: (LuiMenuItemDefinitionExamples new newDefinitionWithLabel: 'Menu 3 Item 1').
	menuDefinition addDefinition: (self submenu_3_2_Definition).
	menuDefinition addDefinition: (self submenu_3_3_Definition).
	^ menuDefinition
]

{ #category : 'as yet unclassified' }
LuiSubmenuDefinitionExamples >> newDefinition [
	<gtExample>
	| menuDefinition |
	menuDefinition := LcsSubmenuDefinition new.
	self assert: menuDefinition cssClasses isEmpty.
	self assert: menuDefinition menuComponentDefintions isEmpty.
	self assert: menuDefinition label isNil.
	self assert: menuDefinition parent isNil.
	self assert: menuDefinition componentName equals: 'nil'.
	^ menuDefinition
]

{ #category : 'as yet unclassified' }
LuiSubmenuDefinitionExamples >> submenu_3_2_Definition [
	<gtExample>
	| menuDefinition |
	menuDefinition := self newDefinition.
	menuDefinition label: 'Menu 3 Item 2'.
	menuDefinition addDefinition: (LuiMenuItemDefinitionExamples new newDefinitionWithLabel: 'Menu 3 Item 2 Submenu Item 1').
	menuDefinition addDefinition: (LuiMenuItemDefinitionExamples new newDefinitionWithLabel: 'Menu 3 Item 2 Submenu Item 2').
	^ menuDefinition
]

{ #category : 'as yet unclassified' }
LuiSubmenuDefinitionExamples >> submenu_3_3_Definition [
	<gtExample>
	| menuDefinition |
	menuDefinition := self newDefinition.
	menuDefinition label: 'Menu 3 Item 3'.
	menuDefinition addDefinition: (LuiMenuItemDefinitionExamples new newDefinitionWithLabel: 'Menu 3 Item 3 Submenu Item 1').
	menuDefinition addDefinition: (LuiMenuItemDefinitionExamples new newDefinitionWithLabel: 'Menu 3 Item 3 Submenu Item 2').
	^ menuDefinition
]
