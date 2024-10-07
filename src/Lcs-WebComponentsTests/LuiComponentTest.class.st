Class {
	#name : #LuiComponentTest,
	#superclass : #TestCase,
	#category : #'Lcs-WebComponentsTests-Tests'
}

{ #category : #'as yet unclassified' }
LuiComponentTest >> testChangingVisibilityBlock [
	| webComponent |
	webComponent := LuiComponent new.
	self assert: webComponent isVisible.
	self deny: webComponent isHidden.
	webComponent halt isVisiblePolicy evaluationBlock: [ false ].
	self deny: webComponent isVisible.
	self assert: webComponent isHidden.

]

{ #category : #test }
LuiComponentTest >> testCreation [
	| webComponent |
	webComponent := LuiComponent new.
	self assert: (webComponent class == LuiComponent).
	self assert: webComponent components isEmpty.
	self assert: webComponent cssClassesString isNil.
	self assert: (webComponent properties isKindOf: LuiComponentProperties).
	self assert: webComponent isVisible.
	self deny: webComponent isHidden.
	self assert: webComponent componentId isNil.
	self assert: webComponent parentComponent isNil.
	self assert: webComponent domainObject isNil
	
]
