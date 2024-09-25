Class {
	#name : #LuiComponentTest,
	#superclass : #TestCase,
	#category : #'Lcs-WebComponentsTests'
}

{ #category : #test }
LuiComponentTest >> testCreation [
	| webComponent |
	webComponent := LuiComponent new.
	self assert: (webComponent class == LuiComponent).
	self assert: webComponent components isEmpty.
	self assert: webComponent cssClassesString isEmpty
	
]
