Class {
	#name : #LuiComponentTest,
	#superclass : #TestCase,
	#category : #'Lcs-WebComponentsTests'
}

{ #category : #'as yet unclassified' }
LuiComponentTest >> testCreation [
	| webComponent |
	webComponent := LuiComponent new.
	self assert: (webComponent class == LuiComponent).
	self assert: webComponent components isEmpty
	
]
