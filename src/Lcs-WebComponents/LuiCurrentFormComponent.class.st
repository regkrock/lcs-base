Class {
	#name : 'LuiCurrentFormComponent',
	#superclass : 'LuiComponent',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'components' }
LuiCurrentFormComponent >> currentForm [
	^ self components at: 'currentForm' ifAbsent: [ nil ]
]

{ #category : 'components' }
LuiCurrentFormComponent >> currentForm: aForm [
	self components at: 'currentForm' put: aForm.
	self componentKeys isEmpty ifTrue: [
		self componentKeys add: 'currentForm' ]
]

{ #category : 'rendering' }
LuiCurrentFormComponent >> renderComponentOn: html [
	self currentForm ifNotNil: [ :form | form renderContentOn: html ]
]
