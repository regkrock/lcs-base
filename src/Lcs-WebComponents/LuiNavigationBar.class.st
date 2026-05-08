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
	component := LuiNavigationMenu named: 'navigation'.
	self addComponent: component.
	self navigationComponent buildFrom: aNavigationMenuDefinition.
	^ component
]

{ #category : 'components' }
LuiNavigationBar >> navigationComponent [
	^ self componentNamed: 'navigation'
]
