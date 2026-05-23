Class {
	#name : 'LuiNavigationBar',
	#superclass : 'LuiComponent',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'components' }
LuiNavigationBar >> addNavigationMenuBuiltFrom: aNavigationMenuDefinition [
	| component |
	component := LuiMenu newMainMenuNamed: 'navigation'.
	self addComponent: component.
	self navigationComponent buildFrom: (LuiNavigationMenuDefinitionExamples new navigationMenuWithThreeMenuItemDefinitions).
	^ component
]

{ #category : 'components' }
LuiNavigationBar >> defaultCssClasses [
	^ #('navBar')
]

{ #category : 'rendering' }
LuiNavigationBar >> navigationComponent [
	^ self componentNamed: 'navigation'
]

{ #category : 'rendering' }
LuiNavigationBar >> renderComponentOn: html [
	self renderOn: html tag: html navigation
]
