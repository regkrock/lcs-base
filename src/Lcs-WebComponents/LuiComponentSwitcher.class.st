Class {
	#name : 'LuiComponentSwitcher',
	#superclass : 'LcsObject',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'components' }
LuiComponentSwitcher >> currentSwitchableComponent [
	^ self components at: 'currentForm' ifAbsent: [ nil ]
]

{ #category : 'components' }
LuiComponentSwitcher >> currentSwitchableComponent: aForm [
	self components at: 'currentForm' put: aForm.
	self componentKeys isEmpty ifTrue: [
		self componentKeys add: 'currentForm' ]
]
