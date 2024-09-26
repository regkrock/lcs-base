Class {
	#name : #LuiComponentTest,
	#superclass : #TestCase,
	#category : #'Lcs-WebComponentsTests'
}

{ #category : #test }
LuiComponentTest >> testCreation [
	| webComponent |
	1 halt.
	webComponent := LuiComponent new.
	self assert: (webComponent class == LuiComponent).
	self assert: webComponent components isEmpty.
	self assert: webComponent cssClassesString isEmpty.
	self assert: webComponent isVisible.
	self assert: webComponent componentId isNil.
	self assert: webComponent parentComponent isNil.
	self assert: webComponent domainObject isNil
	
]
