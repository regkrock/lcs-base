Class {
	#name : #LuiComponentPropertiesTest,
	#superclass : #TestCase,
	#category : #'Lcs-WebComponentsTests-Tests'
}

{ #category : #tests }
LuiComponentPropertiesTest >> testButtonTypeProperty [
	| properties |
	properties := LuiComponentProperties new.
	self assert: properties properties isEmpty.
	self deny: properties hasButtonTypeProperty.
	self assert: (properties valueOfProperty: LuiButtonTypeProperty propertyName) isNil.
	self assert: properties buttonTypeProperty notNil.	"Lazily initialized"
	self assert: (properties valueOfProperty: LuiButtonTypeProperty propertyName) equals: 'button'.
	self assert: properties buttonType equals: 'button'.
	properties buttonTypeProperty beSubmitType.
	self assert: (properties valueOfProperty: LuiButtonTypeProperty propertyName) equals: 'submit'.
	self assert: properties buttonType equals: 'submit'.

]

{ #category : #tests }
LuiComponentPropertiesTest >> testCacheIsClearedWhenBlockIsChanged [
	| properties |
	properties := LuiComponentProperties new.	
	properties title: 'Hello'.
	self assert: properties title equals: 'Hello'.
	self assert: properties titleProperty cachedValue equals: 'Hello'

]

{ #category : #tests }
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
	self deny: properties hasTitleProperty.
	self deny: properties hasButtonTypeProperty
]

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
LuiComponentPropertiesTest >> testLabelProperty [
	| properties |
	properties := LuiComponentProperties new.	
	properties label: 'abcdef'.
	self assert: properties label equals: 'abcdef'.
	self assert: properties labelProperty cachedValue equals: 'abcdef'.
	
	properties label: 'Xxxx'.
	self assert: properties labelProperty cachedValue isNil.
	properties label.
	self assert: properties labelProperty cachedValue equals: 'Xxxx'..
	
	self assert: properties hasLabelProperty

]

{ #category : #tests }
LuiComponentPropertiesTest >> testLazyInitializationOfTitleProperty [
	| properties |
	properties := LuiComponentProperties new.
	self assert: properties properties isEmpty.
	self deny: (properties hasProperty: LuiTitleProperty propertyName).
	self assert: (properties valueOfProperty: LuiTitleProperty propertyName) isNil.
	
	self assert: (properties titleProperty isKindOf: LuiTitleProperty).
	self assert: (properties valueOfProperty: LuiTitleProperty propertyName) isNil
]

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
LuiComponentPropertiesTest >> testSettingTitleWithBlockProperty [
	| properties |
	properties := LuiComponentProperties new.	
	properties titleBlock: [ 'Hello' ].
	self assert: (properties valueOfProperty: LuiTitleProperty propertyName) equals: 'Hello'.
	self assert: properties titleProperty propertyValue equals: 'Hello'.
	self assert: properties title equals: 'Hello'

]

{ #category : #tests }
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

{ #category : #tests }
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
