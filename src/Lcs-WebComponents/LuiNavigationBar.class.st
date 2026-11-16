Class {
	#name : 'LuiNavigationBar',
	#superclass : 'LuiComponent',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'components - utilities' }
LuiNavigationBar >> addNavigationMenuBuiltFrom: aNavigationMenuDefinition [
	| component |
	component := LuiNavigationMenu new.
	self addComponent: component.
	self navigationMenu buildFrom: (LuiNavigationMenuDefinitionExamples new navigationMenuWithThreeMenuItemDefinitions).
	^ component
]

{ #category : 'defaults' }
LuiNavigationBar >> defaultCssClasses [
	^ OrderedCollection with: LuiCssClassesMap / #navbar
]

{ #category : 'initialize' }
LuiNavigationBar >> initialize [
	super initialize.
	self componentName: 'navbar'
]

{ #category : 'components - querying' }
LuiNavigationBar >> navigationMenu [
	^ self componentNamed: 'navMenu'
]

{ #category : 'rendering' }
LuiNavigationBar >> renderComponentOn: html [
	self renderOn: html withinTag: html navigation
]
