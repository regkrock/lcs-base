Class {
	#name : #LuiComponentPropertiesTest,
	#superclass : #TestCase,
	#category : #'Lcs-WebComponentsTests-Tests'
}

{ #category : #'as yet unclassified' }
LuiComponentPropertiesTest >> testCacheIsClearedWhenBlockIsChanged [
	| properties |
	properties := LuiComponentProperties new.	
	properties title: 'Hello'.
	self assert: properties title equals: 'Hello'.
	self assert: properties titleProperty cachedValue equals: 'Hello'

]

{ #category : #'as yet unclassified' }
LuiComponentPropertiesTest >> testCreation [
	| properties |
	properties := LuiComponentProperties new.
	self assert: properties properties isEmpty.
	self deny: (properties hasProperty: 'xxxx').
	self deny: (properties hasProperty: LuiTitleProperty propertyName).
	self deny: properties hasCssClassesProperty.
	self deny: properties hasDisabledProperty.
	self deny: properties hasHiddenProperty.
	self deny: properties hasRequiredProperty.
	self deny: properties hasStyleProperty.
	self deny: properties hasTitleProperty
]

{ #category : #'as yet unclassified' }
LuiComponentPropertiesTest >> testDisabledProperty [
	| properties |
	properties := LuiComponentProperties new.	
	self deny: properties hasDisabledProperty.
	self assert: properties isEnabled.
	properties disabledProperty.
	self assert: properties hasDisabledProperty.
	self assert: properties isEnabled.
	self deny: properties isDisabled.
	
	properties beDisabled.
	self deny: properties isEnabled.
	self assert: properties isDisabled.
	
	properties beEnabled.
	self assert: properties isEnabled.
	self deny: properties isDisabled.
]

{ #category : #'as yet unclassified' }
LuiComponentPropertiesTest >> testHiddenProperty [
	| properties |
	properties := LuiComponentProperties new.	
	self deny: properties hasHiddenProperty.
	self assert: properties isVisible.
	properties hiddenProperty.
	self assert: properties hasHiddenProperty.
	self assert: properties isVisible.
	self deny: properties isHidden.
	
	properties beHidden.
	self deny: properties isVisible.
	self assert: properties isHidden.
	
	properties beVisible.
	self assert: properties isVisible.
	self deny: properties isHidden.
]

{ #category : #'as yet unclassified' }
LuiComponentPropertiesTest >> testLazyInitializationOfTitleProperty [
	| properties |
	properties := LuiComponentProperties new.
	self assert: properties properties isEmpty.
	self deny: (properties hasProperty: LuiTitleProperty propertyName).
	self assert: (properties valueOfProperty: LuiTitleProperty propertyName) isNil.
	
	self assert: (properties titleProperty isKindOf: LuiTitleProperty).
	self assert: (properties valueOfProperty: LuiTitleProperty propertyName) isNil
]

{ #category : #'as yet unclassified' }
LuiComponentPropertiesTest >> testRenderingProperty [
	| properties |
	properties := LuiComponentProperties new.	
	self deny: properties hasRenderingProperty.
	self assert: properties isRenderable.
	properties renderingProperty.
	self assert: properties hasRenderingProperty.
	self assert: properties isRenderable.
	self deny: properties isNotRenderable.
	
	properties beNotRenderable.
	self deny: properties isRenderable.
	self assert: properties isNotRenderable.
	
	properties beRenderable.
	self assert: properties isRenderable.
	self deny: properties isNotRenderable.
]

{ #category : #'as yet unclassified' }
LuiComponentPropertiesTest >> testRequiredProperty [
	| properties |
	properties := LuiComponentProperties new.	
	self deny: properties hasRequiredProperty.
	self assert: properties isOptional.
	properties requiredProperty.
	self assert: properties hasRequiredProperty.
	self assert: properties isOptional.
	self deny: properties isRequired.
	
	properties beRequired.
	self deny: properties isOptional.
	self assert: properties isRequired.
	
	properties beOptional.
	self assert: properties isOptional.
	self deny: properties isRequired.
]

{ #category : #'as yet unclassified' }
LuiComponentPropertiesTest >> testSettingTitleWithBlockProperty [
	| properties |
	properties := LuiComponentProperties new.	
	properties titleBlock: [ 'Hello' ].
	self assert: (properties valueOfProperty: LuiTitleProperty propertyName) equals: 'Hello'.
	self assert: properties titleProperty propertyValue equals: 'Hello'.
	self assert: properties title equals: 'Hello'

]

{ #category : #'as yet unclassified' }
LuiComponentPropertiesTest >> testStyleProperty [
	| properties |
	properties := LuiComponentProperties new.	
	self deny: properties hasStyleProperty.
	self assert: properties style isEmpty.
	
	properties style: 'Test'.
	self assert: properties hasStyleProperty.
	
	self assert: properties style equals: 'Test'.
	
	properties style: 'Xxxx'.
	self assert: properties style equals: 'Xxxx'.
	
	properties appendToStyle: 'Yyyy'.
	self assert: properties style equals: 'XxxxYyyy'
]

{ #category : #'as yet unclassified' }
LuiComponentPropertiesTest >> testTitleProperty [
	| properties |
	properties := LuiComponentProperties new.	
	properties title: 'Test'.
	self assert: properties title equals: 'Test'.
	self assert: properties titleProperty cachedValue equals: 'Test'.
	
	properties title: 'Xxxx'.
	self assert: properties titleProperty cachedValue isNil.
	properties title.
	self assert: properties titleProperty cachedValue equals: 'Xxxx'..
	
	self assert: properties hasTitleProperty

]
