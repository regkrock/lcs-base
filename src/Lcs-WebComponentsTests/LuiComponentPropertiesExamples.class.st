Class {
	#name : 'LuiComponentPropertiesExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiComponentPropertiesExamples >> buttonButtonTypeProperty [
	<gtExample>
	| properties |
	properties := self newComponentProperties.
	self assert: properties buttonTypeProperty notNil.	"Lazily initialized"
	self assert: (properties valueOfProperty: LuiButtonTypeProperty propertyName) equals: 'button'.
	self assert: properties buttonType equals: 'button'.
	^ properties buttonTypeProperty
]

{ #category : 'examples' }
LuiComponentPropertiesExamples >> disabledPropertyInEnabledState [
	<gtExample>
	| properties |
	properties := self newComponentProperties.
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
	^ properties disabledProperty
]

{ #category : 'examples' }
LuiComponentPropertiesExamples >> helloTitlePropertyInitializeFromBlock [
	<gtExample>
	| properties |
	properties := self newComponentProperties.	
	properties titleBlock: [ 'Hello' ].
	self assert: (properties valueOfProperty: LuiTitleProperty propertyName) equals: 'Hello'.
	self assert: properties titleProperty propertyValue equals: 'Hello'.
	self assert: properties title equals: 'Hello'.
	^ properties titleProperty
]

{ #category : 'examples' }
LuiComponentPropertiesExamples >> hiddenPropertySetToVisible [
	<gtExample>
	| properties |
	properties := self newComponentProperties.
	self deny: properties hasVisiblityProperty.
	self assert: properties isVisible.
	properties visibilityProperty.
	self assert: properties hasVisiblityProperty.
	self assert: properties isVisible.
	self deny: properties isHidden.
	
	properties beHidden.
	self deny: properties isVisible.
	self assert: properties isHidden.
	
	properties beVisible.
	self assert: properties isVisible.
	self deny: properties isHidden.
]

{ #category : 'examples' }
LuiComponentPropertiesExamples >> newComponentProperties [
	<gtExample>
	| properties |
	properties := LuiComponentProperties new.
	self assert: properties properties isEmpty.
	self deny: (properties hasProperty: 'xxxx').
	self deny: properties hasTitleProperty.
	self deny: properties hasCssClassesProperty.
	self deny: properties hasDisabledProperty.
	self deny: properties hasVisiblityProperty.
	self deny: properties hasRequiredProperty.
	self deny: properties hasStyleProperty.
	self deny: properties hasTitleProperty.
	self deny: properties hasButtonTypeProperty.
	self assert: (properties valueOfProperty: LuiButtonTypeProperty propertyName) isNil.
	self assert: properties properties isEmpty.
	^ properties
]

{ #category : 'examples' }
LuiComponentPropertiesExamples >> renderingProperty [
	<gtExample>
	| properties |
	properties := self newComponentProperties.
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
	^ properties renderingProperty
]

{ #category : 'examples' }
LuiComponentPropertiesExamples >> requiredPropertySetToTrue [
	<gtExample>
	| properties |
	properties := self newComponentProperties.
	self deny: properties hasRequiredProperty.
	self assert: properties isOptional.
	self assert: properties hasRequiredProperty.
	self assert: properties isOptional.
	self deny: properties isRequired.
	
	properties beRequired.
	self deny: properties isOptional.
	self assert: properties isRequired.
	
	properties beOptional.
	self assert: properties isOptional.
	self deny: properties isRequired.
	^ properties requiredProperty
]

{ #category : 'examples' }
LuiComponentPropertiesExamples >> submitButtonTypeProperty [
	<gtExample>
	| properties |
	properties := self newComponentProperties.
	properties buttonTypeProperty beSubmitType.
	self assert: (properties valueOfProperty: LuiButtonTypeProperty propertyName) equals: 'submit'.
	self assert: properties buttonType equals: 'submit'.
	^ properties buttonTypeProperty
]

{ #category : 'examples' }
LuiComponentPropertiesExamples >> titleCacheIsClearedWhenBlockIsChanged [
	<gtExample>
	| properties |
	properties := self newComponentProperties.	
	properties title: 'Hello'.
	self assert: properties title equals: 'Hello'.
	self assert: properties titleProperty cachedValue equals: 'Hello'.
	^ properties titleProperty
]

{ #category : 'examples' }
LuiComponentPropertiesExamples >> titlePropertyLazilyInitialized [
	<gtExample>
	| properties |
	properties := self newComponentProperties.
	self deny: (properties hasProperty: LuiTitleProperty propertyName).
	self assert: (properties valueOfProperty: LuiTitleProperty propertyName) isNil.
	
	self assert: (properties titleProperty isKindOf: LuiTitleProperty).
	self assert: (properties valueOfProperty: LuiTitleProperty propertyName) isNil.
	^ properties titleProperty
]

{ #category : 'examples' }
LuiComponentPropertiesExamples >> xxxxLabelProperty [
	<gtExample>
	| properties |
	properties := self newComponentProperties.	
	properties label: 'abcdef'.
	self assert: properties label equals: 'abcdef'.
	self assert: properties labelProperty cachedValue equals: 'abcdef'.
	properties label: 'Xxxx'.
	self assert: properties labelProperty cachedValue isNil.
	properties label.
	self assert: properties labelProperty cachedValue equals: 'Xxxx'.
	self assert: properties hasLabelProperty.
	^ properties labelProperty
]

{ #category : 'examples' }
LuiComponentPropertiesExamples >> xxxxTitleProperty [
	<gtExample>
	| properties |
	properties := self newComponentProperties.	
	properties title: 'Test'.
	self assert: properties title equals: 'Test'.
	self assert: properties titleProperty cachedValue equals: 'Test'.
	properties title: 'Xxxx'.
	self assert: properties titleProperty cachedValue isNil.
	properties title.
	self assert: properties titleProperty cachedValue equals: 'Xxxx'.
	self assert: properties hasTitleProperty.
	^ properties titleProperty
]

{ #category : 'examples' }
LuiComponentPropertiesExamples >> xxxxYyyyStyleProperty [
	<gtExample>
	| properties |
	properties := self newComponentProperties.	
	self deny: properties hasStyleProperty.
	self assert: properties style isEmpty.
	properties style: 'Test'.
	self assert: properties hasStyleProperty.
	self assert: properties style equals: 'Test'.
	properties style: 'Xxxx'.
	self assert: properties style equals: 'Xxxx'.
	properties appendToStyle: 'Yyyy'.
	self assert: properties style equals: 'XxxxYyyy'.
	^ properties style
]
